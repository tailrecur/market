class QuarterlyResultSti < ActiveRecord::Migration
  def self.up
      add_column :quarterly_results, :type, :string
      add_column :quarterly_results, :total_interest, :decimal, :precision =>12, :scale => 2
      add_column :quarterly_results, :government_share, :decimal, :precision =>5, :scale => 2
      add_column :quarterly_results, :capital_adequacy_ratio, :decimal, :precision =>5, :scale => 2
  end

  def self.down
      remove_column :companies, :price_to_book_value
      remove_column :companies, :total_interest
      remove_column :companies, :government_share
      remove_column :companies, :capital_adequacy_ratio
  end
end
