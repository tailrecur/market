class FormulaController < ApplicationController
    active_scaffold do |config|
        config.actions = [:list, :create, :update]
        config.columns = [:value, :weightage, :price_dependent, :type, :trend_array]
        config.list.per_page = 100
    end

    def load_data
        TrendFormula.create(:value=>"current.overall_cash > previous.overall_cash", :weightage=>1, :price_dependent=>false, :trend_array=>"balance_sheets")
        TrendFormula.create(:value=>"current.loan_funds < previous.loan_funds", :weightage=>1, :price_dependent=>false, :trend_array=>"balance_sheets")
        TrendFormula.create(:value=>"current.adjusted_no_of_shares < previous.adjusted_no_of_shares", :weightage=>1, :price_dependent=>false, :trend_array=>"balance_sheets")
        TrendFormula.create(:value=>"current.equity_dividend > 0 and previous.equity_dividend > 0", :weightage=>1, :price_dependent=>false, :trend_array=>"profit_and_loss_statements")
        TrendFormula.create(:value=>"current.stock_adjustment < 0 and previous.stock_adjustment < 0", :weightage=>1, :price_dependent=>false, :trend_array=>"quarterly_results")

        SectoralFormula.create(:value=>"company.pe_ratio < sector.pe_ratio", :weightage=>1, :price_dependent=>true)
        SectoralFormula.create(:value=>"company.EVtoSales < sector.EVtoSales", :weightage=>1, :price_dependent=>true)
        SectoralFormula.create(:value=>"company.EVtoEBITDA > sector.EVtoEBITDA", :weightage=>1, :price_dependent=>true)
        SectoralFormula.create(:value=>"company.ROE > sector.ROE", :weightage=>1, :price_dependent=>false)
        SectoralFormula.create(:value=>"company.ROCE > sector.ROCE", :weightage=>1, :price_dependent=>false)
        SectoralFormula.create(:value=>"company.DebttoEquity < sector.DebttoEquity", :weightage=>1, :price_dependent=>false)
        SectoralFormula.create(:value=>"company.price_to_book_value < sector.price_to_book_value", :weightage=>1, :price_dependent=>true)
        SectoralFormula.create(:value=>"company.price_to_market_value < sector.price_to_market_value", :weightage=>1, :price_dependent=>true)

        Formula.create(:value=>"company.sales_growth_rate > company.expenses_growth_rate", :weightage=>1, :price_dependent=>false)
        Formula.create(:value=>"(company.quarterly_growth_rate / company.pe_ratio) > 2", :weightage=>1, :price_dependent=>true)
        Formula.create(:value=>"(company.quarterly_growth_rate / company.pe_ratio) < 1", :weightage=>-1, :price_dependent=>true)
        Formula.create(:value=>"company.balance_sheet.net_cash > 0", :weightage=>1, :price_dependent=>false)
        Formula.create(:value=>"company.balance_sheet.debt_to_capital_ratio > 80", :weightage=>-1, :price_dependent=>false)
        Formula.create(:value=>"company.balance_sheet.debt_to_capital_ratio < 20", :weightage=>1, :price_dependent=>false)
        Formula.create(:value=>"company.balance_sheet.debt_to_assets_ratio > 50", :weightage=>-1, :price_dependent=>false)
        Formula.create(:value=>"company.balance_sheet.acid_test_ratio < 1", :weightage=>-1, :price_dependent=>false)
        Formula.create(:value=>"company.closing_price <= 0.67 * company.NCAVPS", :weightage=>1, :price_dependent=>true)

        redirect_to :action => :index
    end
end
