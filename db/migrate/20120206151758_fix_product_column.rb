class FixProductColumn < ActiveRecord::Migration
  def self.up
    rename_column :products, :category_id, :product_category_id
  end

  def self.down
  end
end
