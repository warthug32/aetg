class AddCoverToNew < ActiveRecord::Migration
  def change
    add_column :news, :cover_file_name, :string

    add_column :news, :cover_content_type, :string

    add_column :news, :cover_file_size, :integer

  end
end
