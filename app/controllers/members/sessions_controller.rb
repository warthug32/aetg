class Members::SessionsController < Devise::SessionsController
  include MainModule
  
  before_filter :set_title, :get_tag
  add_breadcrumb "Home", :root_path
  #add_breadcrumb "Sign In", '/members/sign_in'
  def set_title
    @title = "Sign In"
  end
  
  def get_tag
    @tags = Page.tag_counts_on(:tags)
  end
  
end
