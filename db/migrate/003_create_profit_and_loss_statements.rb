class CreateProfitAndLossStatements < ActiveRecord::Migration
    def self.up
        create_table :profit_and_loss_statements do |t|
            t.column :company_id, :integer, :null => false
            t.column :year_ended, :date, :null => false

            t.column :operating_income, :decimal, :precision => 12, :scale => 2
            t.column :cost_of_sales, :decimal, :precision => 12, :scale => 2
            t.column :material_consumed, :decimal, :precision => 12, :scale => 2
            t.column :manufacturing_expenses, :decimal, :precision => 12, :scale => 2
            t.column :personnel_expenses, :decimal, :precision => 12, :scale => 2
            t.column :selling_expenses, :decimal, :precision => 12, :scale => 2
            t.column :administrative_expenses, :decimal, :precision => 12, :scale => 2
            
            t.column :operating_profit, :decimal, :precision => 12, :scale => 2
            t.column :other_recurring_income, :decimal, :precision => 12, :scale => 2
            t.column :pbdit, :decimal, :precision => 12, :scale => 2
            t.column :financial_expenses, :decimal, :precision => 12, :scale => 2
            t.column :write_offs, :decimal, :precision => 12, :scale => 2
            t.column :pbdt, :decimal, :precision => 12, :scale => 2
            t.column :depreciation, :decimal, :precision => 12, :scale => 2
            t.column :pbt, :decimal, :precision => 12, :scale => 2
            t.column :tax, :decimal, :precision => 12, :scale => 2
            t.column :pat, :decimal, :precision => 12, :scale => 2
            t.column :non_recurring_items, :decimal, :precision => 12, :scale => 2
            t.column :other_non_cash_adjustments, :decimal, :precision => 12, :scale => 2
            t.column :net_profit, :decimal, :precision => 12, :scale => 2
            
            t.column :equity_dividend, :decimal, :precision => 12, :scale => 2
            t.column :preference_dividend, :decimal, :precision => 12, :scale => 2

            t.column :adjusted_eps, :decimal, :precision => 12, :scale => 2
            t.column :reported_eps, :decimal, :precision => 12, :scale => 2
            
            t.column :no_of_shares, :decimal, :precision => 12, :scale => 2
            t.column :face_value, :decimal, :precision => 5, :scale => 2
        end
    end

    def self.down
        drop_table :profit_and_loss_statements
    end
end
