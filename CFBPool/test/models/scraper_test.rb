require 'test_helper'

class ScraperTest < ActiveSupport::TestCase
	def test_simple
		result = Scraper.scrape_data
		puts result
	end

end
