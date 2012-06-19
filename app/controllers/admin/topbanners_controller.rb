class Admin::TopbannersController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @topbanners = Topbanner.all#.paginate(:page => params[:page])
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "Topbanner Management"
  end
  
  def index
    session[:current_page_name] = 'Topbanners'
    @topbanners = Topbanner.all#.paginate(:page => params[:page])
  end
  
  def show
    #@user = User.find(params[:id])
    @topbanners = Topbanner.all#.paginate(:page => params[:page])
    render :action => "index"
  end
  
  def new
    @title = "Add Topbanner"
    @topbanners = Topbanner.new
  end
  
  def edit
    @title = "Edit Topbanner"
    @topbanners = Topbanner.find(params[:id])
  end
  
  def create
    @topbanners = Topbanner.new(params[:topbanners])
    if @topbanners.save
      redirect_to(:url => admin_topbanner_path(@topbanners), :notice => 'Create Topbanner Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @topbanners = Topbanner.find(params[:id])
    @topbanners.last_updated_by = session[:admin_username]
    if @topbanners.update_attributes(params[:topbanners].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_topbanner_path, :notice => 'Update Topbanner Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @topbanners = Topbanner.find(params[:id])
    @topbanners.destroy
    
    redirect_to(admin_topbanners_path)
  end
end
