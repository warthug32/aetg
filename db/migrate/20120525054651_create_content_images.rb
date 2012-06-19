class CreateContentImages < ActiveRecord::Migration
  def self.up
    create_table :content_images do |t|
      t.string :title
      t.text :description
      t.date :publish_date
      t.string :last_updated_by
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.string :parent
      t.integer :display_order
      t.string :locale
      t.boolean :activate
      t.timestamps
    end
  end

  def self.down
    drop_table :content_images
  end
end
