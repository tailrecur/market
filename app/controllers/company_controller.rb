require 'retrieval/nse_reader'
require 'calculation/calculator'
require 'retrieval/stockhive_reader'
require 'retrieval/data_manager'
require 'retrieval/uri'

class CompanyController < ApplicationController

    active_scaffold do |config|
        config.actions = [:list, :live_search]
        config.columns = [:name, :stockhive_code, :score, :sector_name, :pe_ratio, :quarterly_growth_rate, :closing_price, :previous_closing_price,  :traded_value]
        config.action_links.add 'update_financial_data', :label => 'Update Financial Data', :method => :post, :type => :table, :page => true
        config.action_links.add 'update_trading_data', :label => 'Update Trading Data', :method => :post, :type => :table, :page => true
        config.action_links.add 'update_companies_list', :label => 'Update Companies List', :method => :post, :type => :table, :page => true
        config.action_links.add 'update_calculations', :label => 'Update Calculations', :method => :post, :type => :table, :page => true
        config.action_links.add 'update_stockhive_code', :label => 'Update Stockhive Code', :method => :post, :type => :table, :page => true
        config.action_links.add 'calculate_score', :label => 'Calculate Score', :method => :post, :type => :table, :page => true
        config.list.per_page = 100
        config.list.sorting = {:score => :desc}

        config.columns[:sector_name].search_sql = '(select name from sectors where sectors.id = companies.sector_id)'

        config.live_search.columns = [:name, :sector_name]

        config.columns[:name].set_link('details')
    end

    def update_companies_list
        NseReader.update_companies_list
        redirect_to :action => :index
    end

    def update_trading_data
        NseReader.update_trading_data
        redirect_to :action => :index
    end

    def update_stockhive_code
        DataManager.update_stockhive_code
        redirect_to :action => :index
    end

    def calculate_score
        Company.transaction do
#                        companies = [] << Company.find(843)
            #            companies = [] << Company.find_by_name("Northgate Technologies Limited")
            companies = Company.find(:all)
            formulae = Formula.find(:all)

            for company in companies
                calculator = Calculator.new company
                calculator.apply_formulae(formulae)
            end
        end
        redirect_to :action => :index
    end

    def update_calculations
#        companies = [] << Company.find(655)
        companies = Company.find(:all)
        Company.transaction do
            for company in companies
                pp "Company - #{company.name}"
                company.update_calculations
                company.save
            end
        end

        companies = Company.find(:all)
        sectors = Sector.find(:all)
        Sector.transaction do
            for sector in sectors
                sector.update_calculations(companies.select{|company| company.sector_id == sector.id})
            end
        end
        redirect_to :action => :index
    end

    def update_financial_data
#        StockhiveReader.new(Company.find(:all,
#                        :conditions => "stockhive_code not in (null, 'not_present') and id not in (select company_id from quarterly_results group by company_id)"
#                )).update_financial_data
        StockhiveReader.new(Company.find(:all, :conditions => "id > 626")).update_financial_data
#        StockhiveReader.new(Company.find(:all)).update_financial_data
        #        StockhiveReader.new([] << Company.find(:first)).update_financial_data
        redirect_to :action => :index
    end

    def details
        @company = Company.find(params[:id])
        calculator = Calculator.new(@company)
        @passing_formulae = calculator.evaluate_formulae(Formula.find(:all))
        @extrapolated_scores = calculator.extrapolate_score

        pp @extrapolated_scores
    end

    def conditions_for_collection
        "name is not null"
    end
end
