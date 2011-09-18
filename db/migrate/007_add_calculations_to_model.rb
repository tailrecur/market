class AddCalculationsToModel < ActiveRecord::Migration
  def self.up
      add_column :companies, :sales_growth_rate, :decimal, :precision =>12, :scale => 2
      add_column :companies, :expenses_growth_rate, :decimal, :precision =>12, :scale => 2
      add_column :companies, :quarterly_growth_rate, :decimal, :precision =>12, :scale => 2
      add_column :companies, :eps, :decimal, :precision =>12, :scale => 2
      add_column :companies, :pe_ratio, :decimal, :precision =>12, :scale => 2
      add_column :companies, :EVtoSales, :decimal, :precision =>12, :scale => 2
      add_column :companies, :EVtoEBITDA, :decimal, :precision =>12, :scale => 2
      add_column :companies, :ROE, :decimal, :precision =>12, :scale => 2
      add_column :companies, :ROCE, :decimal, :precision =>12, :scale => 2
      add_column :companies, :DebttoEquity, :decimal, :precision =>12, :scale => 2
      add_column :companies, :NCAVPS, :decimal, :precision =>12, :scale => 2

      add_column :sectors, :EVtoSales, :decimal, :precision =>12, :scale => 2
      add_column :sectors, :EVtoEBITDA, :decimal, :precision =>12, :scale => 2
      add_column :sectors, :ROE, :decimal, :precision =>12, :scale => 2
      add_column :sectors, :ROCE, :decimal, :precision =>12, :scale => 2
      add_column :sectors, :DebttoEquity, :decimal, :precision =>12, :scale => 2
  end

  def self.down
      remove_column :companies, :sales_growth_rate
      remove_column :companies, :expenses_growth_rate
      remove_column :companies, :quarterly_growth_rate
      remove_column :companies, :eps
      remove_column :companies, :pe_ratio
      remove_column :companies, :EVtoSales
      remove_column :companies, :EVtoEBITDA
      remove_column :companies, :ROE
      remove_column :companies, :ROCE
      remove_column :companies, :DebttoEquity
      remove_column :companies, :NCAVPS

      remove_column :sectors, :EVtoSales
      remove_column :sectors, :EVtoEBITDA
      remove_column :sectors, :ROE
      remove_column :sectors, :ROCE
      remove_column :sectors, :DebttoEquity
  end
end
