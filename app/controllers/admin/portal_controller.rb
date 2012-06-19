class Admin::PortalController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :login_required, :except => [:login]
  
  def set_title
     @title = "Home"
  end
   
  def login
    if request.post?
      if @user = User.authenticate(params[:Username],params[:Password])
        @user.update_attributes(:last_login_at => Time.current, :last_ip => request.env['REMOTE_ADDR'])
        @user.save
        session[:admin_user] = @user.id
        session[:admin_username] = @user.username
        session[:admin_role] = @user.role
        if params[:remember_me]
          userId = @user.id.to_s
          cookies[:remember_me_id] = {:value => userId, :expires => 30.days.from_now}
          userCode = Digest::SHA1.hexdigest(@user.email)[4,18]
          cookies[:remember_me_code] = {:value => userCode, :expires => 30.days.from_now}
        end
        redirect_to_stored
        return
      else
        flash[:error] = 'Invalid username or password!'
      end
    else
      if(cookies[:remember_me_id] and cookies[:remember_me_code] and User.exists?(cookies[:remember_me_id]) and Digest::SHA1.hexdigest(User.where(:id => cookies[:remember_me_id]).first.email)[4,18] == cookies[:remember_me_code])
        admin = User.find(cookies[:remember_me_id])  
        session['admin_user'] = admin.id
        session[:admin_username] = admin.username
        session[:admin_role] = admin.role
        redirect_to_stored
        return
      end
    end
    render :layout => false
  end
   
  def logout
    session = nil
    reset_session
    if cookies[:remember_me_id] then cookies.delete :remember_me_id end
    if cookies[:remember_me_code] then cookies.delete :remember_me_code end
    redirect_to :action => :login
  end
  
  def index
    @title_action = "Home"
    session[:current_page_name] = "Dashboard"
  end
  
  
end
