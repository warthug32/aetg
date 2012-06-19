class CreateJobPosts < ActiveRecord::Migration
  
  def self.up
    create_table :job_posts do |t|
      t.string :position
      t.string :reference_code
      t.string :location
      t.integer :work_type
      t.float :salary
      t.integer :job_industry_id
      t.integer :job_classification_id
      t.integer :company_id
      t.text :description
      t.text :requirements
      t.string :locale
      t.string :last_updated_by
      t.boolean :activate
      t.date :publish_date
      t.timestamps
    end
  end

  def self.down
    drop_table :job_posts
  end
  
end
