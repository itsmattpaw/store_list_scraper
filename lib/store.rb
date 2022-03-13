require 'nokogiri'
require 'open-uri'
require 'pry'

class Store  
    attr_accessor :idnum, :address, :city, :state, :zip 
    @@all = []

    def initialize(idnum:,address:,city:,state:,zip:)
        @idnum = idnum
        @address = address
        @city = city
        @state = state
        @zip = zip
        @@all << self
    end

    def self.all
        @@all
    end

end