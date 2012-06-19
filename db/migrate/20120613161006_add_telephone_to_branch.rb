class AddTelephoneToBranch < ActiveRecord::Migration
  def change
    add_column :branches, :telephone, :string
    add_column :branches, :fax, :string
  end
end
