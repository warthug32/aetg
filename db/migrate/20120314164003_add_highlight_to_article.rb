class AddHighlightToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :highlight, :boolean

  end
end
