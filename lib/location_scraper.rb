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

    def page_scrape(page)
        doc = Nokogiri::HTML5(URI.open(page))
        doc.css(".main-block a").each do |lk| #pull all links from main body 
          j = lk.attribute("href").text #look at only the url text
          case j.split("/").length 
          when 3 
            @state_pages << j
          when 4
            @city_pages << j
          when 5
            @loc_pages << j
          end
        end
      end

end
