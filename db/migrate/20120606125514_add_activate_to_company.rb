class AddActivateToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :activate, :boolean
  end
end
