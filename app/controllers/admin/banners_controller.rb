class Admin::BannersController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @banners = Banner.all#.paginate(:page => params[:page])
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "Banner Management"
  end
  
  def index
    session[:current_page_name] = 'Banners'
    @banners = Banner.all#.paginate(:page => params[:page])
  end
  
  def show
    #@user = User.find(params[:id])
    @banners = Banner.all#.paginate(:page => params[:page])
    render :action => "index"
  end
  
  def new
    @title = "Add Banner"
    @banners = Banner.new
  end
  
  def edit
    @title = "Edit Banner"
    @banners = Banner.find(params[:id])
  end
  
  def create
    @banners = Banner.new(params[:banners])
    if @banners.save
      redirect_to(:url => admin_banner_path(@banners), :notice => 'Create Banner Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @banners = Banner.find(params[:id])
    @banners.last_updated_by = session[:admin_username]
    if @banners.update_attributes(params[:banners].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_banner_path, :notice => 'Update Banner Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @banners = Banner.find(params[:id])
    @banners.destroy
    
    redirect_to(admin_banners_path)
  end
end
