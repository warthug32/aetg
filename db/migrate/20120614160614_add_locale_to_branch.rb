class AddLocaleToBranch < ActiveRecord::Migration
  def change
    add_column :branches, :locale, :string
    add_column :branches, :activate, :boolean
  end
end
