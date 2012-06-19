class FixContentImageParentColumn < ActiveRecord::Migration
  def self.up
    rename_column :content_images, :parent, :page_id
  end

  def self.down
    rename_column :content_images, :page_id, :parent
  end
end
