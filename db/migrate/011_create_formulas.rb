class CreateFormulas < ActiveRecord::Migration
  def self.up
    create_table :formulas do |t|
        t.column :value, :string
        t.column :weightage, :integer
        t.column :price_dependent, :boolean
        t.column :type, :string
        t.column :trend_array, :string
    end
  end

  def self.down
    drop_table :formulas
  end
end


