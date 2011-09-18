class AddAcidTestRatio < ActiveRecord::Migration
  def self.up
      add_column :companies, :acid_test_ratio, :decimal, :precision =>12, :scale => 2
  end

  def self.down
      remove_column :companies, :acid_test_ratio
  end
end
