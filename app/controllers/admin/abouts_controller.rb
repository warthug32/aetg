class Admin::AboutsController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:new, :create, :destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @about = About.all#.paginate(:page => params[:page])
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "About Page Management"
  end
  
  def index
    session[:current_page_name] = 'Abouts'
    @about = About.all#.paginate(:page => params[:page])
  end
  
  def show
    #@user = User.find(params[:id])
    @about = About.all#.paginate(:page => params[:page])
    render :action => "index"
  end
  
  def new
    @title = "Add About Page"
    @about = About.new
  end
  
  def edit
    @title = "Edit About Page"
    @about = About.find(params[:id])
  end
  
  def create
    @about = About.new(params[:about])
    if @about.save
      redirect_to(:url => admin_about_path(@about), :notice => 'Create About Page Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @about = About.find(params[:id])
    @about.last_updated_by = session[:admin_username]
    if @about.update_attributes(params[:about].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_about_path, :notice => 'Update About Page Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @about = About.find(params[:id])
    @about.destroy
    
    redirect_to(admin_abouts_path)
  end
  
end
