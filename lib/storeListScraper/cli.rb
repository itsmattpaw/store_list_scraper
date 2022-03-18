
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
            list_view
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
            list_view
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

    def list_view
        puts "\nThis is a list of 27,000+ businesses,\nHow would you like to view it?\n1) select a letter group\n2) search a keyword\n3) return to main menu"
        case gets.strip.to_i
        when 1
            puts "Please type letter(s) you want at the START of the business name:"
            ListScraper::CSVmanager.list_view_by_letter(gets.strip)
            list_validation
        when 2
            puts "Please type the keyword as you expect to see it in the business name.\n(example: 'Jimmy's Pizza' contains 'Pizza'"
            ListScraper::CSVmanager.list_view_by_search(gets.strip)
            list_validation
        when 3
            menu
        else
            puts "\n(ರ_ರ)\nThat is not a valid input.."
            list_view
        end
    end

    def list_validation
        puts "\nSelect the number next to the business name you want to scrape\n OR type 'menu' to return to main menu."
        input = gets.strip
        if input == "menu"
            menu
        elsif ListScraper::CSVmanager.search_results[input.to_i] != nil
             puts "Confirm you want to scrape (y/n):\n#{ListScraper::CSVmanager.search_results[input.to_i][0]}"
             gets.strip.downcase == 'y' ? scrape(ListScraper::CSVmanager.search_results[input.to_i][1]): list_validation
        else
            puts "\n(ರ_ರ)\nThat is not a valid input.."
            list_validation
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
            puts "...\n( ◉_◉)\nExporting now, this can take awhile. I will alert when done."
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