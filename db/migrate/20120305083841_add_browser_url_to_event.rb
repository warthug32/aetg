class AddBrowserUrlToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :browser_url, :string
  end

  def self.down
    remove_column :events, :browser_url
  end
end
