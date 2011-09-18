class ProfitAndLossStatement < ActiveRecord::Base

    belongs_to :company, :counter_cache => true

    validates_uniqueness_of :year_ended, :scope => "company_id"

    def self.column_associations
        return  {
                "period_ended" => :year_ended,

                "Operating Income" => :operating_income,
                "Cost of Sales" => :cost_of_sales,
                "Material Consumed" => :material_consumed,
                "Manufacturing Expenses" => :manufacturing_expenses,
                "Personnel Expenses" => :personnel_expenses,
                "Selling Expenses" => :selling_expenses,
                "Administrative Expenses" => :administrative_expenses,

                "Operating Profit" => :operating_profit,
                "Add: Other Recurring Income" => :other_recurring_income,
                "Adjusted PBDIT" => :pbdit,
                "Less: Financial Expenses" => :financial_expenses,
                "Less: Other Write Offs" => :write_offs,
                "Adjusted PBDT" => :pbdt,
                "Less: Depreciation" => :depreciation,
                "Adjusted PBT" => :pbt,
                "Less: Tax Charges" => :tax,
                "Adjusted PAT" => :pat,

                "Add: Non-Recurring Items" => :non_recurring_items,
                "Add: Other Non-Cash Adjustments" => :other_non_cash_adjustments,
                "Reported Net Profit" => :net_profit,

                "Equity Dividend" => :equity_dividend,
                "Preference Dividend" => :preference_dividend,

                "EPS (Adjusted for splits and bonuses)*" => :adjusted_eps,
                "Reported EPS" => :reported_eps,

                "Equity Shares Outstanding (in Crores)" => :no_of_shares,
                "Face Value (Rs.)" => :face_value
        }
    end

    def self.find_by_period_ended(company_id, period_ended)
        ProfitAndLossStatement.find(:first, :conditions => ["company_id = ? and year_ended = ?",company_id, period_ended])
    end

    def <=> other
        year_ended <=> other.year_ended
    end
end
