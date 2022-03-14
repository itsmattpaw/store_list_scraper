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

    def page_scrape(page, type = 'all')
        begin
            doc = Nokogiri::HTML5(URI.open(page))
            doc.css(".main-block a").each do |lk| #pull all links from main body 
                j = lk.attribute("href").text #look at only the url text
                case type
                when 'all'
                    case j.split("/").length
                    when 3 
                        @state_pages << j
                    when 4
                        @city_pages << j
                    when 5
                        @loc_pages << j
                    end
                when 'State'
                    case j.split("/").length
                    when 4
                        @city_pages << j
                    when 5
                        @loc_pages << j
                    end
                when 'City'
                    case j.split("/").length
                    when 5
                        @loc_pages << j
                    end
                end
            end
        rescue #OpenURI::HTTPError => e
        end
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
            linked_page_scrape(@state_pages,'State')
            linked_page_scrape(@city_pages,'City')
        elsif @city_pages.length > 0
            linked_page_scrape(@city_pages,'City')
        end
      end

      def linked_page_scrape(array,type)
        total = array.length
        i = 0
        array.each do |page|
            i += 1
            page_scrape("#{@@base}#{page}","#{type}")
            prog = (i.to_f/total.to_f)*100
            print "#{type} Progress: #{i}/#{total}\r"
            print "#{prog.round(2)}% complete\r"
        end
      end

      def create_stores
        total = @loc_pages.length
        i = 1
        @loc_pages.each do |loc|
            begin
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
                prog = (i.to_f/total.to_f)*100
                print "#{type} Progress: #{i}/#{total}\r"
                print "#{prog.round(2)}% complete\r"
                i += 1
            rescue
                next
            end
        end
      end

end
