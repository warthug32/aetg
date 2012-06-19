class JobClassification < ActiveRecord::Base
  has_many :job_posts
  validates_presence_of :name
  validates_uniqueness_of :name, :message => "already exists."
end
