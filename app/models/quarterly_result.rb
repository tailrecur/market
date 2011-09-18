class   QuarterlyResult < ActiveRecord::Base
    belongs_to :company, :counter_cache => true

    validates_uniqueness_of :quarter_ended, :scope => "company_id"

    def self.column_associations
        return {
                "period_ended" => :quarter_ended,
                "Total Income" => :total_income,
                "Net Sales" => :net_sales,
                "Sales" => :sales,
                "Less: Excise" => :excise,
                "Other Recurring Income" => :other_income,

                "Total Expenses" => :total_expenses,
                "Stock Adjustment" => :stock_adjustment,
                "Raw Material" => :raw_materials,
                "Employee Expenses" => :employee_expenses,
                "Other Expenses" => :other_expenses,

                "PBDIT" => :pbdit,
                "Less: Interest" => :interest,

                "PBDT" => :pbdt,
                "Less: Depreciation" => :depreciation,
                "PBT" => :pbt,
                "Less: Tax" => :tax,
                "Add: Extraordinary Item" => :extraordinary_item,
                "Net Profit" => :net_profit,

                "EPS (Adjusted for splits and bonuses)" => :eps,
                "Equity Capital" => :equity_capital,
                "Face Value (Rs.)" => :face_value,
                "Outstanding Shares (Cr.)" => :no_of_shares,
                "Aggregate of Non-Promoter Shareholding (%)" => :public_shareholding
        }
    end

    def self.find_by_period_ended(company_id, period_ended)
        QuarterlyResult.find(:first, :conditions =>["company_id = ? and quarter_ended = ?",company_id, period_ended])
    end

    def <=> other
        quarter_ended <=> other.quarter_ended
    end
end
