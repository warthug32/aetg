class CreateBranches < ActiveRecord::Migration
  def self.up
    create_table :branches do |t|
      t.string :name
      t.text :description
      t.text :address
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps

      t.timestamps
    end
  end

  def self.down
    drop_table :branches
  end
end
