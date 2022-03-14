require 'nokogiri'
require 'open-uri'
require 'CSV'
require 'pry'

class UpdateScraper 
    attr_accessor :letters, :pages, :list
    attr_reader :base

    def initialize
        @base = 'https://storefound.org/'
        @letters = [] #array of links for each letter group
        @pages = [] #array to store pages for each letter
        File.delete('./lib/business_list.csv') if File.exist?('./lib/business_list.csv')
        c = CSV.open("./lib/business_list.csv", "w")
        c << ["Company Name", "link"] #headers
    end

    def letters_scrape

        #scrape all main links for letters group
    end

    def pages_scrape
        #scrape all page links for each letter group
    end

    def update_business_list
        #scrape all business names and corresponding links
    end

end

UpdateScraper.new