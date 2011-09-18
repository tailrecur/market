require 'retrieval/retrieval_helper'

class NseReader
    @@company_list_url = "http://www.nseindia.com/content/equities/EQUITY_L.csv"
    @@trading_data_url = "http://nseindia.com/content/historical/EQUITIES/<D1>/cm<D2>bhav.csv"

    def self.update_companies_list
        retrieve_csv_and_update(@@company_list_url)
    end

    def self.update_trading_data
        retrieve_csv_and_update
    end

    def self.retrieve_csv_and_update
        csv_data = retrieve_trading_csv
        companies_csv = csv_data.split("\n")
        header_data =  companies_csv.first.split(",")
        companies_csv.delete companies_csv.first
        Company.transaction do
            for company_csv in companies_csv do
                attribute_map = RetrievalHelper.create_attribute_map(Company, header_data, company_csv.split(","))
                company = Company.find_or_initialize_by_nse_symbol(attribute_map[:nse_symbol])
                company.update_attributes(attribute_map)
            end
        end
    end

    def self.retrieve_trading_csv
        day = Date.today
        csv_data = "Not Found"
        while (csv_data.include?("Not Found"))
            day -= 1
            trading_url = @@trading_data_url.sub("<D1>", day.strftime("%Y/%b").upcase).sub("<D2>", day.strftime("%d%b%Y").upcase)
            csv_data = RetrievalHelper.retrieve trading_url
        end

        return csv_data
    end
end