require 'pry'
require 'csv'

class CSVexport  
    attr_accessor :name

    def initialize(name)
        @name = name
    end

    def locations_export
        c = CSV.open("#{@name}.csv", "w")
        c << ["IDnum", "Address", "City", "State", "ZIP"] #headers
        Store.all.each do |loc|
            c << [loc.idnum, loc.address, loc.city, loc.state, loc.zip]
        end
        c.close()
    end

    def self.business_list_check(company)
        #check for business existance on file
        CSV.foreach("./lib/business_list.csv") do |row|
            if row[0] == company
                return row[1]
            end
        end
    end
end