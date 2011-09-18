class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
        t.column :nse_symbol, :string, :null => false
        t.column :stockhive_code, :string
        t.column :name, :string
        t.column :listing_date, :date
        t.column :face_value, :decimal, :precision => 8, :scale => 3
    end
  end

  def self.down
    drop_table :companies
  end
end
