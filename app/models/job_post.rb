class JobPost < ActiveRecord::Base
  belongs_to :company
  belongs_to :job_industry
  belongs_to :job_classification
  validates_numericality_of :salary1
  validates_numericality_of :salary2
  validates_presence_of :company, :message => "Please Select Company"
  
  
end
