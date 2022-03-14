require_relative '../lib/csv_export.rb'
require_relative '../lib/location_scraper.rb'
require_relative '../lib/store.rb'
require_relative '../lib/update_scraper.rb'
require 'pry'

class CommandLineInterface

    def start #greet user with menu
        puts "Hello user! ヽ(‘ ∇‘ )ノ"
        menu
    end

    def menu
        puts "What are we interested in accomplishing today?"
        puts "1) New Scrape"
        puts "2) Update Business List"
        puts "3) Exit Program"
        input = gets.strip.to_i
        if input == 1
            #run new scrape
            puts "starting scrape!"
        elsif input == 2
            #run update to Business List
            puts "Updating!!!"
        elsif input == 3
            puts "(◕‿◕)"
            puts "Goodbye friend!"
            exit
        else
            puts "(￣ｰ￣)"
            puts "That is not a valid input.."
            menu
        end
    end

end

CommandLineInterface.new.start