class CreateJobIndustries < ActiveRecord::Migration
   def self.up
    create_table :job_industries do |t|
      t.string :name
      t.string :locale
      
      
      t.timestamps
    end
  end

  def self.down
    drop_table :job_industries
  end
end
