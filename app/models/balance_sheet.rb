class BalanceSheet < ActiveRecord::Base

    belongs_to :company, :counter_cache => true

    validates_uniqueness_of :year_ended, :scope => "company_id"

    def self.column_associations
        return {
                "period_ended" => :year_ended,

                "Shareholder's Funds" =>  :shareholders_funds,
                "Equity Capital" =>  :equity_capital,
                "Share Application Money" =>  :share_application_money,
                "Preference Capital" =>  :preference_capital,
                "Reserves and Surplus" =>  :reserves_and_surplus,

                "Loan Funds" =>  :loan_funds,
                "Secured Loans" =>  :secured_loans,
                "Unsecured Loans" =>  :unsecured_loans,
                "Total" =>  :total_funds,

                "Fixed Assets" =>  :fixed_assets,
                "Net Block" =>  :net_block,
                "Gross Block" =>  :gross_block,
                "Less: Revaluation Reserves" =>  :revaluation_reserves,
                "Less: Accumulated Depreciation" =>  :accumulated_depreciation,
                "Capital Work in Progress" =>  :capital_work_in_progress,
                "Investments" =>  :investments,

                "Net Current Assets" =>  :net_current_assets,
                "Current Assets, Loans & Advances" =>  :current_assets,
                "Less: Current Liabilities & Provisions" =>  :current_liabilities,
                "Misc Expenses Not Written Off" =>  :expenses_not_written_off,

                "Book Value of Unquoted Investments" =>  :unquoted_investments_book_value,
                "Market Value of Quoted Investments" =>  :quoted_investments_market_value,
                "Contingent Liabilities" =>  :contingent_liabilities,

                "Equity Shares Outstanding (in Crores)" =>  :no_of_shares,
                "Face Value (Rs.)" =>  :face_value
        }
    end


    def self.find_by_period_ended(company_id, period_ended)
        BalanceSheet.find(:first, :conditions => ["company_id = ? and year_ended = ?",company_id, period_ended])
    end


    def net_cash
        overall_cash - loan_funds
    end

    def overall_cash
        net_current_assets + investments
    end

    def adjusted_no_of_shares
        no_of_shares * face_value
    end

    def debt_to_capital_ratio
        (loan_funds / (loan_funds+shareholders_funds)) * 100
    end

    def debt_to_equity_ratio
        (loan_funds / shareholders_funds) * 100 if !loan_funds.nil?
    end

    def NCAVPS
        (net_current_assets - loan_funds - preference_capital)/no_of_shares   if !(loan_funds.nil? || net_current_assets.nil?)
    end

    def debt_to_assets_ratio
        (loan_funds / fixed_assets) * 100
    end

    def acid_test_ratio
        (current_assets + investments) / current_liabilities if !(current_assets.nil? || current_liabilities.nil?)
    end

    def book_assets
        total_funds
    end

    def market_assets
        fixed_assets + net_current_assets + unquoted_investments_book_value + quoted_investments_market_value
    end

    def <=> other
        year_ended <=> other.year_ended
    end
end
