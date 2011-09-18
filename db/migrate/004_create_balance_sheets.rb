class CreateBalanceSheets < ActiveRecord::Migration
    def self.up
        create_table :balance_sheets do |t|
            t.column :company_id, :integer, :null => false
            t.column :year_ended, :date, :null => false

            t.column :shareholders_funds, :decimal, :precision => 12, :scale => 2
            t.column :equity_capital, :decimal, :precision => 12, :scale => 2
            t.column :share_application_money, :decimal, :precision => 12, :scale => 2
            t.column :preference_capital, :decimal, :precision => 12, :scale => 2
            t.column :reserves_and_surplus, :decimal, :precision => 12, :scale => 2

            t.column :loan_funds, :decimal, :precision => 12, :scale => 2
            t.column :secured_loans, :decimal, :precision => 12, :scale => 2
            t.column :unsecured_loans, :decimal, :precision => 12, :scale => 2
            t.column :total_funds, :decimal, :precision => 12, :scale => 2

            t.column :fixed_assets, :decimal, :precision => 12, :scale => 2
            t.column :net_block, :decimal, :precision => 12, :scale => 2
            t.column :gross_block, :decimal, :precision => 12, :scale => 2
            t.column :revaluation_reserves, :decimal, :precision => 12, :scale => 2
            t.column :accumulated_depreciation, :decimal, :precision => 12, :scale => 2
            t.column :capital_work_in_progress, :decimal, :precision => 12, :scale => 2
            t.column :investments, :decimal, :precision => 12, :scale => 2

            t.column :net_current_assets, :decimal, :precision => 12, :scale => 2
            t.column :current_assets, :decimal, :precision => 12, :scale => 2
            t.column :current_liabilities, :decimal, :precision => 12, :scale => 2
            t.column :expenses_not_written_off, :decimal, :precision => 12, :scale => 2

            t.column :unquoted_investments_book_value, :decimal, :precision => 12, :scale => 2
            t.column :quoted_investments_market_value, :decimal, :precision => 12, :scale => 2
            t.column :contingent_liabilities, :decimal, :precision => 12, :scale => 2

            t.column :no_of_shares, :decimal, :precision => 12, :scale => 2
            t.column :face_value, :decimal, :precision => 12, :scale => 2
        end
    end

    def self.down
        drop_table :balance_sheets
    end
end
