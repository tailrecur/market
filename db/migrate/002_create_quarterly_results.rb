class CreateQuarterlyResults < ActiveRecord::Migration
    def self.up
        create_table :quarterly_results do |t|
            t.column :company_id, :integer, :null => false
            t.column :quarter_ended, :date, :null => false

            t.column :total_income, :decimal, :precision => 12, :scale => 2
            t.column :net_sales, :decimal, :precision => 12, :scale => 2
            t.column :sales, :decimal, :precision => 12, :scale => 2
            t.column :excise, :decimal, :precision => 12, :scale => 2
            t.column :other_income, :decimal, :precision => 12, :scale => 2

            t.column :total_expenses, :decimal, :precision => 12, :scale => 2
            t.column :stock_adjustment, :decimal, :precision => 12, :scale => 2
            t.column :raw_materials, :decimal, :precision => 12, :scale => 2
            t.column :employee_expenses, :decimal, :precision => 12, :scale => 2
            t.column :other_expenses, :decimal, :precision => 12, :scale => 2

            t.column :pbdit, :decimal, :precision => 12, :scale => 2
            t.column :interest, :decimal, :precision => 12, :scale => 2
            t.column :pbdt, :decimal, :precision => 12, :scale => 2
            t.column :depreciation, :decimal, :precision => 12, :scale => 2
            t.column :pbt, :decimal, :precision => 12, :scale => 2
            t.column :tax, :decimal, :precision => 12, :scale => 2
            t.column :extraordinary_item, :decimal, :precision => 12, :scale => 2
            t.column :net_profit, :decimal, :precision => 12, :scale => 2

            t.column :eps, :decimal, :precision => 12, :scale => 2
            t.column :equity_capital, :decimal, :precision => 12, :scale => 2
            t.column :face_value, :decimal, :precision => 8, :scale => 3
            t.column :no_of_shares, :decimal, :precision => 8, :scale => 2
            t.column :public_shareholding, :decimal, :precision => 5, :scale => 2
        end
    end

    def self.down
        drop_table :quarterly_results
    end
end
