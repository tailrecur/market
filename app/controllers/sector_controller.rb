class SectorController < ApplicationController
    active_scaffold do |config|
        config.actions = [:list]
        config.columns = [:name, :companies_count, :eps, :pe_ratio,:EVtoSales, :EVtoEBITDA, :ROE, :ROCE, :DebttoEquity, :NCAVPS]
#        config.action_links.add 'update_financial_data', :label => 'Update Financial Data', :method => :post, :type => :table, :page => true
#        config.action_links.add 'update_trading_data', :label => 'Update Trading Data', :method => :post, :type => :table, :page => true
#        config.action_links.add 'update_companies_list', :label => 'Update Companies List', :method => :post, :type => :table, :page => true
#        config.action_links.add 'update_calculations', :label => 'Update Calculations', :method => :post, :type => :table, :page => true
#        config.action_links.add 'update_stockhive_code', :label => 'Update Stockhive Code', :method => :post, :type => :table, :page => true
#        config.action_links.add 'calculate_score', :label => 'Calculate Score', :method => :post, :type => :table, :page => true
        config.list.per_page = 100
        config.list.sorting = {:companies_count => :desc}
    end
end
