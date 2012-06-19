class FixContentImageColumn < ActiveRecord::Migration
  def self.up
    rename_column :content_images, :image_file_name, :content_image_file_name
    rename_column :content_images, :image_content_type, :content_image_content_type
    rename_column :content_images, :image_file_size, :content_image_file_size
  end

  def self.down
    rename_column :content_images, :content_image_file_name, :image_file_name
    rename_column :content_images, :content_image_content_type, :image_content_type
    rename_column :content_images, :content_image_file_size, :image_file_size
  end
end
