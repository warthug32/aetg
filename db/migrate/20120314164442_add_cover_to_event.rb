class AddCoverToEvent < ActiveRecord::Migration
  def change
    add_column :events, :cover_file_name, :string

    add_column :events, :cover_content_type, :string

    add_column :events, :cover_file_size, :integer

  end
end
