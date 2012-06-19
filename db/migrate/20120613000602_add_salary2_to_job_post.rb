class AddSalary2ToJobPost < ActiveRecord::Migration
  def self.up
    rename_column :job_posts, :salary, :salary1
    add_column :job_posts, :salary2, :float
  end
  
  def self.down
    rename_column :job_posts, :salary1, :salary
    drop_column :job_posts, :salary2
  end
end
