class AddLocaleToProductCategory < ActiveRecord::Migration
  def self.up
    add_column :product_categories, :locale, :string
  end

  def self.down
    remove_column :product_categories, :locale
  end
end
