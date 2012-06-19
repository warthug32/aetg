class AddContentToContentImage < ActiveRecord::Migration
  def change
    add_column :content_images, :content, :text
  end
end
