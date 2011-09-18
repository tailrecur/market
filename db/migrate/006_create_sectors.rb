class CreateSectors < ActiveRecord::Migration
  def self.up
    create_table :sectors do |t|
        t.column :name, :string
        t.column :eps, :decimal, :precision => 12, :scale => 2
        t.column :pe_ratio, :decimal, :precision => 12, :scale => 2
    end
    add_column :companies, :sector_id, :integer
  end

  def self.down
    drop_table :sectors
    remove_column :companies, :sector_id
  end
end
