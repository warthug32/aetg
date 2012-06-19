class AddBrowserUrlToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :browser_url, :string
  end

  def self.down
    remove_column :articles, :browser_url
  end
end
