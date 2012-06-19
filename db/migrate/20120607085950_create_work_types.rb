class CreateWorkTypes < ActiveRecord::Migration
  def self.up
    create_table :work_types do |t|
      t.string :name
      t.string :locale
    end
    create_default
  end

  def self.down
    drop_table :work_types
  end

  def self.create_default
    WorkType.create :name=>"Permanent",:locale=>"en"
    WorkType.create :name=>"Full-Time",:locale=>"en"
    WorkType.create :name=>"Part-Time",:locale=>"en"
    WorkType.create :name=>"Contract / Project-based",:locale=>"en"
    WorkType.create :name=>"Freelance",:locale=>"en"
    WorkType.create :name=>"Temporary",:locale=>"en"
    WorkType.create :name=>"Internship / OJT",:locale=>"en"
  end
end


