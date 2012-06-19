class User < ActiveRecord::Base
  belongs_to :district
  has_many :comments
  
  attr_protected :id
  attr_accessor :password, :password_confirmation
  
  #Validate Presence
  validates_presence_of :username
  validates_presence_of :hashed_password
  validates_presence_of :email
  #Validate Length
  validates_length_of :username, :within => 3..20
  validates_length_of :email, :within => 3..50
  validates_length_of :password, :within => 3..20, :on => :create
  validates_length_of :password_confirmation, :within => 3..20, :on => :update, :if => :password_required?
  #Validate Uniqueness
  validates_uniqueness_of :username, :message => "was in use. Please use another username"
  validates_uniqueness_of :email, :on => :create, :message => "was in use. Please use another email"
  #Confirmation
  validates_confirmation_of :password, :on => :create
  validates_confirmation_of :password, :on => :update, :if => :password_required?
  #Validate Format
  validates_format_of :email, :with =>/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  validates_format_of :username, :with => /^[a-zA-Z0-9_]{3,20}$/
  
  #Method
    def self.authenticate(login, pass)
       admin = User.where(:username => login).first
       return nil if admin.nil?
       return admin if User.encrypt(pass) == admin.hashed_password
       nil
     end

     def password=(pass)
       @password = pass
       self.hashed_password = User.encrypt(@password)
     end

     protected

     def password_required?
       !password.blank?
     end

     def self.encrypt(pass)
        Digest::MD5.hexdigest(pass)
     end
     
  
end
