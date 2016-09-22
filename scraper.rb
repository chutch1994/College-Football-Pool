 # scraper.rb

require 'nokogiri'
require 'open-uri'

class Scraper
	def self.scrape_data

		# Grab the XML page where the spreads are.
		doc = Nokogiri::XML(open('http://xml.pinnaclesports.com/pinnaclefeed.aspx?sporttype=Football&sportsubtype=NCAA').read)	
		
		# Parse the data
		gamesXML = doc.xpath("//pinnacle_line_feed/events/event")

		gamesArray = Array.new

		gamesXML.each do |game|
			teams = game.xpath("participants/participant")
			away_team= teams[0].xpath("participant_name/text()").to_s
			home_team = teams[1].xpath("participant_name/text()").to_s

			# Parse out the spread.
			periods = game.xpath("periods/period")
			spread = nil
			periods.each do |period|
				if (period.xpath("period_description/text()").to_s == "Game")
					spread = period.xpath("spread/spread_visiting/text()").to_s.to_f
				end
			end

			# Figure out who the favored team is.
			favored_team = spread.to_f < 0 ? away_team : home_team

			# Spread should always be negative.
			spread = spread.to_f > 0 ? -spread.to_f : spread.to_f
	
			# Pack all of that into a hash.
			game = {
				:HomeTeam => home_team,
				:AwayTeam => away_team,
				:FavoredTeam => favored_team,
				:Spread => spread
				}
			
			# Store the hash in an array.
			gamesArray.push(game)
		end

		return gamesArray
	end

end
