require 'nokogiri'
require 'open-uri'
require 'pry'

class UpdateScraper 
    attr_accessor :letters, :pages
    attr_reader :base

    def initialize
        @base = 'https://storefound.org/'
        @letters = [] #array of links for each letter group
        @pages = [] #array to store pages for each letter
    end

end