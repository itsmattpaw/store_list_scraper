
class ListScraper::CLI

    def start #greet user with menu
        puts ""
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
            new_scrape
        elsif input == 2
            list_update
        elsif input == 3
            puts ""
            puts "(⌐■_■)ノ"
            puts "Goodbye friend!"
            exit
        else
            puts ""
            puts "(ರ_ರ)"
            puts "That is not a valid input.."
            puts ""
            menu
        end
    end

    def new_scrape
        puts ""
        puts "(∪ ◡ ∪)"
        puts "So you want to run a scrape?"
        puts "Please type a company name as found in my Business List."
        puts "Or 'menu' to return to the main menu"
        name_check
    end

    def name_check
        input = gets.strip
        if input == "menu"
            menu
        else  
            #check business list for name
            link = ListScraper::CSVexport.business_list_check(input)
            if link != nil
                #run scrape on business
                puts ""
                puts "( ﾟヮﾟ)"
                puts link
                puts "Found the business! Want me to scrape a list? (y/n)"
                confimation = gets.strip
                confimation == 'y' ? scrape(link) : exit
            else  
                puts ""
                puts "(●_●)"
                puts "Sorry, but it doesn't look like that's on the list."
                puts "Please enter another name" 
                puts "OR type 'menu' to return to the main menu"
                name_check
            end
        end
    end

    def scrape(link)
        a = ListScraper::LocationScraper.new("#{ListScraper::LocationScraper.base}#{link}")
        a.page_scrape(a.link)
        a.clean_out
        puts ""
        puts "( ◕‿◕)"
        puts "I found #{a.loc_pages.length} locations for this business."
        puts "Would you like to export? (y/n)"
        confirmation = gets.strip
        if confirmation == 'y'
            puts ""
            puts "(°ロ°)☝"
            puts "What would you like to name the file?"
            fileName = gets.strip
            puts "..."
            puts "◉_◉"
            puts "Exporting now, this can take awhile. I will alert when done."
            a.create_stores
            ListScraper::CSVexport.locations_export(fileName)
            puts "Export Completed Successfully!"
        else
            puts ""
            puts "(⌐■_■)ノ"
            puts "I hope you have a great day!"
            puts "Goodbye"
            exit
        end
    end

    def list_update
        puts ""
        puts "⊙﹏⊙"
        puts "Running update, this could take several minutes.."
        #run update scrape
        ListScraper::UpdateScraper.new
    end

end