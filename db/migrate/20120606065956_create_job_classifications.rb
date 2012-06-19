class CreateJobClassifications < ActiveRecord::Migration
   
   def self.up
    create_table :job_classifications do |t|
      t.string :name
      t.string :locale
      
      t.timestamps
    end
  end

  def self.down
    drop_table :job_classifications
  end
  
end
