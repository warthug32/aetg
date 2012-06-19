class AddDisplayOrderToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :display_order, :integer
  end

  def self.down
    remove_column :pages, :display_order
  end
end
