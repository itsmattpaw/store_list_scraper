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
        @list = CSV.open("./lib/business_list.csv", "w")
        @list << ["Company Name", "link"] #headers
        update
    end

    def update
        letters_scrape
        @letters.each do |letter|
            pages_scrape(letter)
            update_business_list
        end
        puts "Successfully updated!!"
    end

    def letters_scrape
        #scrape all main links for letters group
        doc = Nokogiri::HTML5(URI.open('https://storefound.org/store/starts-a/page-1'))
        doc.css('.letter-block a').each do |lk|
            @letters << lk.attribute('href').text
        end
    end

    def pages_scrape(letter_link)
        #scrape all page links for each letter group
        @pages.clear
        doc = Nokogiri::HTML5(URI.open("#{@base}#{letter_link}"))
        doc.css('.pagination a').each do |lk|
            @pages << lk.attribute('href').text
        end
    end

    def update_business_list
        #scrape all business names and corresponding links
        @pages.each do |lk|
            doc = Nokogiri::HTML5(URI.open("#{@base}#{lk}"))
            j = doc.css('.main-block .col-half a').each do |biz|
                @list << [biz.text, biz.attribute('href').text]
            end
        end
    end
end

UpdateScraper.new