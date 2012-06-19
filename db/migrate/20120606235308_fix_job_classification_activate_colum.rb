class FixJobClassificationActivateColum < ActiveRecord::Migration
  def self.up
    remove_column :job_classifications, :activate
    add_column :job_classifications, :last_updated_by, :string
  end

  def self.down
    add_column :job_classifications, :activate, :integer
    remove_column :job_classifications, :last_updated_by
  end
end
