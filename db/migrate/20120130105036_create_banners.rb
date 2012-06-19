class CreateBanners < ActiveRecord::Migration
  def self.up
    create_table :banners do |t|
      t.string :title
      t.text :description
      t.date :publish_date
      t.string :last_updated_by
      t.text :tag
      t.string :banner_file_name
      t.string :banner_content_type
      t.integer :banner_file_size
      t.string :locale
      t.boolean :activate
      t.text :url

      t.timestamps
    end
  end

  def self.down
    drop_table :banners
  end
end
