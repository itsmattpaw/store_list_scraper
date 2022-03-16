
require_relative "storeListScraper/version"
require_relative "storeListScraper/cli"
require_relative "storeListScraper/csv_manage"
require_relative "storeListScraper/location_scraper"
require_relative "storeListScraper/store"
require_relative "storeListScraper/update_scraper"

require "rake"
require 'pry'
require 'Nokogiri'
require 'Open-URI'
require 'csv'

module ListScraper
    class Error < StandardError; end
end