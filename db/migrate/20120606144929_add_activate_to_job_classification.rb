class AddActivateToJobClassification < ActiveRecord::Migration
  def change
    add_column :job_classifications, :activate, :boolean
  end
end
