class AddActivateToJobIndustry < ActiveRecord::Migration
  def change
    add_column :job_industries, :activate, :boolean
  end
end
