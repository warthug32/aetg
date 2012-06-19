class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :address, 
  :organization_name_zh, :self_introduction_gb, :job_title_zh, :title, :first_name_gb, 
  :job_title, :last_name_zh, :address_zh, :organization_name_gb, :job_title_gb, 
  :organization_name, :last_name_gb, :address_gb, :self_introduction, :last_name, :website, 
  :department_zh, :telephone, :department, :self_introduction_zh, :first_name, :first_name_zh, 
  :department_gb, :industry_id, :educategory_id, :nature_id, :resume, :cv, :country
  
  belongs_to :nature
  belongs_to :educategory
  belongs_to :industry
  has_many :articles
  has_attached_file :resume,
    :url  => "/members/resumes/:id/:basename.:extension",
    :path => ":rails_root/public/members/resumes/:id/:basename.:extension"
  has_attached_file :cv,
    :url  => "/members/resumes/:id/:basename.:extension",
    :path => ":rails_root/public/members/cvs/:id/:basename.:extension"
  
  validates_attachment_content_type :resume, :content_type => [ "application/msword", "application/ms-word", "application/pdf", "application/x-pdf", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"],
    :message => "Resume must be in pdf/doc/docx format!"
  validates_attachment_content_type :cv, :content_type => [ "application/msword", "application/ms-word", "application/pdf", "application/x-pdf", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"],
    :message => "Cover Letter must be in pdf/doc/docx format!"
   
  
  def self.search(search)
    if search
      where('organization_name LIKE ? OR organization_name_zh LIKE ? OR organization_name_gb LIKE ?', "%#{search}%","%#{search}%","%#{search}%")
    else
      scoped
    end
  end
end
