class FixJobIndustryActivateColumn < ActiveRecord::Migration
  
  def self.up
    remove_column :job_industries, :activate
    add_column :job_industries, :last_updated_by, :string
  end

  def self.down
    add_column :job_industries, :activate, :integer
    remove_column :job_industries, :last_updated_by
  end
  
end
