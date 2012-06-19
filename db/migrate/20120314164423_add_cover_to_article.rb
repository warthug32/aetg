class AddCoverToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :cover_file_name, :string

    add_column :articles, :cover_content_type, :string

    add_column :articles, :cover_file_size, :integer

  end
end
