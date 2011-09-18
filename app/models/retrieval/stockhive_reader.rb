require 'mechanize'
require 'retrieval/retrieval_helper'

class StockhiveReader
    @@company_url = "http://www.stockhive.com/company/financials/"
#    @@company_url = "http://localhost:3000/mocks/stockhive/financials.htm"
    @@login_url = "http://www.stockhive.com/home/login"

    attr_accessor :company_url, :login_url

    @@child_models = {QuarterlyResult => "quarterly_results", BankQuarterlyResult => "quarterly_results",
            ProfitAndLossStatement => "profit_and_loss_statements", BalanceSheet => "balance_sheets"}


    @@model_mappings = {"Finance - Banks - Private Sector" => BankQuarterlyResult, "Finance - Banks - Public Sector" => BankQuarterlyResult}

    def initialize companies
        @companies = companies
        @agent = WWW::Mechanize.new
        @agent.post(@@login_url, "logging_in_user[email]"=>"deepak.lewis@gmail.com", "logging_in_user[password]"=>"dlewis")
#                @agent.post("file:///C:/workspace/market/test/mocks/stockhive/login.htm", "logging_in_user[email]"=>"deepak.lewis@gmail.com", "logging_in_user[password]"=>"dlewis")
    end

    def update_financial_data
#        Company.transaction do
        for company in @companies
            pp company.name
            begin
                html_data = @agent.post(@@company_url + company.stockhive_code)

                #            company.sector = retrieve_sector(html_data.search("//table[@id='table7']/tr[3]/td"))
                financial_data_table = html_data.search("//table[@id='table10']")

                #           financial_data_table = html_data.search("//table[@id='table10']")
                pp "Size #{financial_data_table.size}"

                financial_data_table.each do |table|
                    save_financial_data(company, QuarterlyResult, table) if valid_financial_table?(table, "Quarterly Details")
                    save_financial_data(company, ProfitAndLossStatement, table) if valid_financial_table?(table, "Profit and Loss Details")
                    save_financial_data(company, BalanceSheet, table) if valid_financial_table?(table, "Balance Sheet Details")
                end

                #            save_financial_data company, QuarterlyResult, html_data.search("//table[@id='quarterly_details']")
                #            save_financial_data company, ProfitAndLossStatement, html_data.search("//table[@id='profit_and_loss_details']")
                #            save_financial_data company, BalanceSheet, html_data.search("//table[@id='balance_sheet_details']//table[@id='table10']")

                company.save
            rescue
            end
        end
    end

    private

    def model_class(sector, type)

    end

    def valid_financial_table?(financial_table, section_name)
        financial_table.parent.parent.parent.previous.previous.previous.previous.innerHTML.include?(section_name)
    end

    def retrieve_sector sector_data
        sector_name = RetrievalHelper.extract_leaf(sector_data)
        pp sector_name
        sector = Sector.find_by_name(sector_name)
        sector = Sector.new(:name=>sector_name) if sector.nil?
        return sector
    end

    def get_model_class(sector_name, model_class)
        @@model_mappings[sector_name] || model_class
    end

    def save_financial_data company, child_class, data_table
        return if data_table.nil?
        begin
            header_data, financial_data = extract_financial_data data_table
            new_child_class = get_model_class(company.sector.name, child_class)
            new_child_class.transaction do
                for index in 0..(financial_data.size - 1)
                    attribute_map = RetrievalHelper.create_attribute_map new_child_class, header_data, financial_data[index]
                    attribute_map[:company_id] = company.id
                    child_record = new_child_class.find_by_period_ended(company.id, financial_data[index].first)
                    pp "Child record - #{!child_record.nil?}"
                    if (child_record.nil?)
                        company.send(@@child_models[new_child_class]).create(attribute_map)
                    else
                        child_record.update_attributes(attribute_map)
                    end
                end
            end
        rescue
        end
    end

    def extract_financial_data data_table
        header_data = ["period_ended"]
        financial_data = []

        header_columns = data_table.search("//tr[1]//td")
        header_columns.delete(header_columns.first)
        header_columns.each do |column|
            financial_data << ([] << Date.parse(RetrievalHelper.extract_leaf(column)))
        end

        header_rows = data_table.search("//tr")
        header_rows.delete(header_rows.first)
        header_rows.delete(header_rows.first)

        header_rows.each do |row|
            columns = row.search("//td")
            header_data << RetrievalHelper.extract_leaf(columns[0])
            for index in 0..(header_columns.size - 1)
                financial_data[index] << RetrievalHelper.extract_leaf(columns[index+1])
            end
        end
        return header_data, financial_data
    end
end