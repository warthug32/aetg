class AddUrlToContentImage < ActiveRecord::Migration
  def change
    add_column :content_images, :url, :string
  end
end
