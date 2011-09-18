require 'calculation/utility'

class Sector < ActiveRecord::Base
    validates_uniqueness_of :name

    has_many :companies

    @@calculations = [:eps, :pe_ratio,:EVtoSales, :EVtoEBITDA, :ROE, :ROCE, :DebttoEquity, :price_to_book_value, :price_to_market_value]

    def update_calculations(companies)
        return if companies.size <= 1

        @@calculations.each do |calc|
            self.send("#{calc}=", Utility.avg(companies, calc))
        end
        self.save
    end

    def companies_count
        companies.size
    end
end
