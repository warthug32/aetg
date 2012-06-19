class AddLastupdateToProductCategory < ActiveRecord::Migration
  def self.up
    add_column :product_categories, :last_updated_by, :string
  end

  def self.down
    remove_column :product_categories, :last_updated_by
  end
end
