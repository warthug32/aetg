class CreatePositions < ActiveRecord::Migration
  def self.up
    create_table :positions do |t|
      t.string :name
      t.string :locale
      t.string :last_updated_by
      
      t.timestamps
    end
  end

  def self.down
    drop_table :positions
  end
end
