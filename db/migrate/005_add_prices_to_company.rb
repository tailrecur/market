class AddPricesToCompany < ActiveRecord::Migration
  def self.up
      add_column :companies, :closing_price, :decimal, :precision =>12, :scale => 2
      add_column :companies, :previous_closing_price, :decimal, :precision =>12, :scale => 2
      add_column :companies, :traded_quantity, :integer
      add_column :companies, :traded_value, :decimal, :precision =>20, :scale => 2
      add_column :companies, :score, :integer
  end

  def self.down
      remove_column :companies, :closing_price 
      remove_column :companies, :previous_closing_price
      remove_column :companies, :traded_quantity
      remove_column :companies, :traded_value 
      remove_column :companies, :score
  end
end
