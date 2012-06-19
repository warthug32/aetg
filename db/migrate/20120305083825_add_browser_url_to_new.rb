class AddBrowserUrlToNew < ActiveRecord::Migration
  def self.up
    add_column :news, :browser_url, :string
  end

  def self.down
    remove_column :news, :browser_url
  end
end
