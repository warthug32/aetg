class UserMailer < ActionMailer::Base
  default :from => "noreply@defapp.com"
  
  require 'mail'

  def enquiry_email(enquiry)
      @enquiry = enquiry
      mail(:to => "tony.lau@defapp.com, michael.chak@defapp.com",
           :subject => "Def App - Web Enquiry")
  end
  
end
