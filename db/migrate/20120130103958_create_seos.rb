class CreateSeos < ActiveRecord::Migration
  def self.up
    create_table :seos do |t|
      t.text :meta_description
      t.text :meta_author
      t.text :meta_keywords

      t.timestamps
    end
  end

  def self.down
    drop_table :seos
  end
end
