
class ListScraper::CLI

    def start #greet user with menu
        puts "\nHello user! ヽ(‘ ∇‘ )ノ"
        menu
    end

    def menu
        puts "\nWhat are we interested in accomplishing today?\n1) New Scrape\n2) View Business List\n3) Update Business List\n4) Exit Program\n"
        case gets.strip.to_i
        when 1
            new_scrape
        when 2
            puts "viewing"
        when 3
            list_update
        when 4
            puts "\n(⌐■_■)ノ\nGoodbye friend!\n"
            exit
        else
            puts "\n(ರ_ರ)\nThat is not a valid input.."
            menu
        end
    end

    def new_scrape
        puts "\n(∪ ◡ ∪)\nSo you want to run a scrape?\nPlease type a company name as found in my Business List.\nOR type 'list' to view the Business List\nOr 'menu' to return to the main menu"
        name_check
    end

    def name_check
        input = gets.strip
        case input
        when "list"
            puts "viewing"
        when "menu"
            menu
        else  
            #check business list for name
            link = ListScraper::CSVmanager.business_list_check(input)
            if link != nil
                puts "\n( ﾟヮﾟ)\nFound the business! Want me to scrape a list? (y/n)"
                confimation = gets.strip
                confimation == 'y' ? scrape(link) : exit
            else
                puts "\n(●_●)\nSorry, but it doesn't look like that's on the list.\nPlease enter another name\nOR type 'list' to view my Business List\nOR type 'menu' to return to the main menu"
                name_check
            end
        end
    end

    def scrape(link)
        a = ListScraper::LocationScraper.new("#{ListScraper::LocationScraper.base}#{link}")
        a.page_scrape(a.link)
        a.clean_out
        puts "\n( ◕‿◕)\nI found #{a.loc_pages.length} locations for this business.\nWould you like to export? (y/n)"
        confirmation = gets.strip
        if confirmation == 'y'
            puts "\n(°ロ°)☝\nWhat would you like to name the file?"
            fileName = gets.strip
            puts "...\n◉_◉\nExporting now, this can take awhile. I will alert when done."
            a.create_stores
            ListScraper::CSVmanager.locations_export(fileName)
            puts "Export Completed Successfully!"
        else
            puts "\n(⌐■_■)ノ\nI hope you have a great day!\nGoodbye"
            exit
        end
    end

    def list_update
        puts "\n⊙﹏⊙\nRunning update, this could take several minutes.."
        ListScraper::UpdateScraper.new
    end

end