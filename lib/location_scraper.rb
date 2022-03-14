require 'nokogiri'
require 'open-uri'
require 'pry'

class LocationScraper 
    attr_accessor :link, :state_pages, :city_pages, :loc_pages
    @@base = 'https://storefound.org/'

    def initialize(link)
        @link = link
        @state_pages = []
        @city_pages = []
        @loc_pages = []
    end

    def self.base
        @@base
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
        rescue OpenURI::HTTPError => e
            #if e.message == '404 Not Found'
            #    puts "404"
            #end
      end

    #when running a store, the first table of links will
    #only ever be states, cities, or locations. On state pages,
    #cities will be picked up at the bottom and need to be removed
    #clean_out will determine next steps and de-duplicate arrays
    #clean_out can only be used after the first pass
      def clean_out
        @state_pages.uniq!
        @city_pages.uniq!
        @loc_pages.uniq!
        if @state_pages.length > 0 #if state links avaliable, clean other arrays and scrape each state
            @city_pages.clear
            @loc_pages.clear
            linked_page_scrape(@state_pages)
            linked_page_scrape(@city_pages)
        elsif @city_pages.length > 0
            linked_page_scrape(@city_pages)
        elsif @loc_pages.length > 0
            #create stores
        end
      end

      def linked_page_scrape(array)
        array.each do |page|
          page_scrape("#{@@base}#{page}")
        end
      end

      def create_stores
        i = 1
        @loc_pages.each do |loc|
          loc = Nokogiri::HTML5(URI.open("#{@@base}#{loc}"))
            j = loc.css("li span")
            info = {
              idnum: i,
              address: j[0].text,
              city: j[1].text,
              state: j[2].text,
              zip: j[3].text
            }
            Store.new(info)
            i += 1
        end
      end

end
