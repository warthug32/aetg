class AddRoleToMember < ActiveRecord::Migration
  def change
    add_column :members, :role, :string

  end
end
