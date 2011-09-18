require 'hpricot'
require 'calculation/utility'

class Company < ActiveRecord::Base
    has_many :quarterly_results
    has_many :profit_and_loss_statements
    has_many :balance_sheets
    belongs_to :sector, :counter_cache => true

    validates_uniqueness_of :nse_symbol, :name

    def self.column_associations
        return {
                "SYMBOL" => :nse_symbol,
                "NAME OF COMPANY" =>  :name,
                "DATE OF LISTING" =>  :listing_date,
                "FACE VALUE" =>  :face_value,
                "CLOSE" =>  :closing_price,
                "PREVCLOSE" =>  :previous_closing_price,
                "TOTTRDQTY" =>  :traded_quantity,
                "TOTTRDVAL" =>  :traded_value
        }
    end

    def update_calculations
        return if balance_sheets.size == 0 or profit_and_loss_statements.size == 0 or quarterly_results.size == 0
        self.sales_growth_rate = Utility.sales_growth_rate(self)
        self.expenses_growth_rate = Utility.sales_growth_rate(self)
        self.quarterly_growth_rate = Utility.quarterly_growth_rate(self)
        self.eps = Utility.trailing_eps(self)
        self.pe_ratio = Utility.pe_ratio(self)

        self.ROE = (profit_and_loss.pat/ balance_sheet.shareholders_funds) * 100
        self.ROCE = (profit_and_loss.operating_profit / balance_sheet.total_funds) * 100
        self.DebttoEquity = balance_sheet.debt_to_equity_ratio
        self.NCAVPS = ncavps
        self.acid_test_ratio = balance_sheet.acid_test_ratio

        if (quarterly_result.no_of_shares > 0 && !closing_price.nil?)
            ev = enterprise_value
            sales = yearly_sales
            self.EVtoSales = ev / sales if sales != 0
            self.EVtoEBITDA = ev / profit_and_loss.pbdit if !profit_and_loss.pbdit.nil?
            self.price_to_book_value = closing_price / book_value
            self.price_to_market_value = closing_price / market_value
        end
    end

    def book_value
        balance_sheet.book_assets / quarterly_result.no_of_shares
    end

    def market_value
        balance_sheet.market_assets / quarterly_result.no_of_shares
    end

    def ncavps
        (balance_sheet.net_current_assets - balance_sheet.loan_funds - balance_sheet.preference_capital)/quarterly_result.no_of_shares if quarterly_result.no_of_shares != 0
    end

    def market_cap
        quarterly_result.no_of_shares * closing_price
    end

    def enterprise_value
        market_cap + balance_sheet.loan_funds + balance_sheet.preference_capital - cash_and_cash_equivalents
    end

    def cash_and_cash_equivalents
        balance_sheet.investments + balance_sheet.net_current_assets
    end

    def balance_sheet
        @balance_sheet = Utility.sort(self.balance_sheets).first if @balance_sheet.nil?
        return @balance_sheet
    end

    def profit_and_loss
        @profit_and_loss = Utility.sort(self.profit_and_loss_statements).first if @profit_and_loss.nil?
        return @profit_and_loss
    end

    def quarterly_result
        @quarterly_result = Utility.sort(self.quarterly_results).first if @quarterly_result.nil?
        return @quarterly_result
    end

    def yearly_sales
        Utility.sort(self.quarterly_results).slice(0, 4).sum(&:sales)
    end

    def sector_name
        sector.name
    end
end

