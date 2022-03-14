require 'pry'
require 'csv'

class CSVexport

    def self.locations_export(name)
        c = CSV.open("#{name}.csv", "w")
        c << ["IDnum", "Address", "City", "State", "ZIP"] #headers
        Store.all.each do |loc|
            c << [loc.idnum, loc.address, loc.city, loc.state, loc.zip]
        end
        c.close()
    end

    def self.business_list_check(company)
        #check for business existance on file
        h = CSV.read("./lib/business_list.csv").find {|row| row[0] == "#{company}"}
        h != nil ? h[1] : nil
    end
end