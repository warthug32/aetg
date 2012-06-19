class AddHighlightToEvent < ActiveRecord::Migration
  def change
    add_column :events, :highlight, :boolean

  end
end
