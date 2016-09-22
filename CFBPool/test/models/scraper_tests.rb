# scraper_tests.rb

require_relative "scraper"
require "test/unit"

class TestScraper < Test::Unit::TestCase

	def test_simple
		result = Scraper.scrape_data
		puts result
	end
end
