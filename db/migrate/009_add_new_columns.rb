class AddNewColumns < ActiveRecord::Migration
  def self.up
      add_column :companies, :price_to_book_value, :decimal, :precision =>12, :scale => 2
      add_column :companies, :price_to_market_value, :decimal, :precision =>12, :scale => 2

      add_column :sectors, :price_to_book_value, :decimal, :precision =>12, :scale => 2
      add_column :sectors, :price_to_market_value, :decimal, :precision =>12, :scale => 2

      add_column :sectors, :companies_count, :integer, :default => 0
  end

  def self.down
      remove_column :companies, :price_to_book_value
      remove_column :companies, :price_to_market_value

      remove_column :sectors, :price_to_book_value
      remove_column :sectors, :price_to_market_value
      remove_column :sectors, :companies_count
  end
end
