class FixMembersColumn < ActiveRecord::Migration
  def up
      
      remove_column :members, :department_gb
      remove_column :members, :self_introduction_gb
      remove_column :members, :organization_name_gb
      
      remove_column :members, :industry_id
      remove_column :members, :educategory_id
      remove_column :members, :nature_id
      
      add_column :members, :gender, :string
      add_column :members, :date_of_brith, :date
      add_column :members, :mobile, :string
  end

  def down
  end
end
