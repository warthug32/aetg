class Company < ActiveRecord::Base
  has_many :job_posts, :dependent => :destroy
  accepts_nested_attributes_for :job_posts, :allow_destroy => true
  validates_presence_of :name
  validates_presence_of :email
  validates_format_of :email, :with =>/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
end
