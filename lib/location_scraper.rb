require 'nokogiri'
require 'open-uri'
require 'pry'

class LocationScraper 
    attr_accessor :link, :state_pages, :city_pages, :loc_pages
    attr_reader :base

    def initialize(link)
        @link = link
        @base = 'https://storefound.org/'
        @state_pages = []
        @city_pages = []
        @loc_pages = []
    end

end