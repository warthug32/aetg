class AddHighlightToNew < ActiveRecord::Migration
  def change
    add_column :news, :highlight, :boolean

  end
end
