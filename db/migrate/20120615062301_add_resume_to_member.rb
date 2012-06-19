class AddResumeToMember < ActiveRecord::Migration
  def change
    add_column :members, :resume_file_name, :string

    add_column :members, :resume_content_type, :string

    add_column :members, :resume_file_size, :integer
    
    add_column :members, :cv_file_name, :string

    add_column :members, :cv_content_type, :string

    add_column :members, :cv_file_size, :integer
    
  end
end
