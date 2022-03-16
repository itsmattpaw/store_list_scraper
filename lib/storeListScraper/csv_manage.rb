
class ListScraper::CSVmanager

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
        puts g
    end

    def self.list_view_by_search(word)
        g = word
        puts g
    end
end