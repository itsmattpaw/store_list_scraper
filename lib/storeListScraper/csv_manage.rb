
class ListScraper::CSVmanager
    @@search_results = {}

    def self.locations_export(name)
        c = CSV.open("#{name}.csv", "w")
        c << ["IDnum", "Address", "City", "State", "ZIP"] #headers
        ListScraper::Store.all.each do |loc|
            c << [loc.idnum, loc.address, loc.city, loc.state, loc.zip]
        end
        c.close()
    end

    def self.business_list_check(company)
        #check for business existance on file
        h = CSV.read("./lib/storeListScraper/business_list.csv").find {|row| row[0] == "#{company}"}
        h != nil ? h[1] : nil
    end

    def self.list_view_by_letter(letter)
        g = CSV.read("./lib/storeListScraper/business_list.csv").select {|row| row[0].downcase.start_with?("#{letter.downcase}")}
        ListScraper::CSVmanager.list_view_selection(g)
    end

    def self.list_view_by_search(word)
        g = CSV.read("./lib/storeListScraper/business_list.csv").select {|row| row[0].downcase.include?("#{word.downcase}")}
        ListScraper::CSVmanager.list_view_selection(g)
    end

    def self.list_view_selection(g)
        @@search_results.clear
        i = 1
        g.each do |item|
            puts "#{i}: #{item[0]}"
            @@search_results[i] = item
            i += 1
        end
    end

    def self.search_results
        @@search_results
    end
end