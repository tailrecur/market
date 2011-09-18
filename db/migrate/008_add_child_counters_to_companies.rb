class AddChildCountersToCompanies < ActiveRecord::Migration
  def self.up
      add_column :companies, :quarterly_results_count, :integer, :default => 0
      add_column :companies, :balance_sheets_count, :integer, :default => 0
      add_column :companies, :profit_and_loss_statements_count, :integer, :default => 0
  end

  def self.down
      remove_column :companies, :quarterly_results_count
      remove_column :companies, :balance_sheets_count
      remove_column :companies, :profit_and_loss_statements_count
  end
end
