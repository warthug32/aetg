class CreatePartners < ActiveRecord::Migration
  def self.up
    create_table :partners do |t|
      
      t.string :title
      t.text :description
      t.date :publish_date
      t.string :last_updated_by
      t.text :tag
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.string :locale
      t.boolean :activate
      t.text :url
      
      t.timestamps
    end
  end
  
  def self.down
    drop_table :partners
  end
  
end
