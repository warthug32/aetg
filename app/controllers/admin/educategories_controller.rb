class Admin::EducategoriesController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:new, :create, :destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @educategory = Educategory.all#.paginate(:page => params[:page])
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "Educategory Page Management"
  end
  
  def index
    session[:current_page_name] = 'Educategories'
    @educategory = Educategory.all#.paginate(:page => params[:page])
  end
  
  def show
    #@user = User.find(params[:id])
    @educategory = Educategory.all#.paginate(:page => params[:page])
    render :action => "index"
  end
  
  def new
    @title = "Add Educategory Page"
    @educategory = Educategory.new
  end
  
  def edit
    @title = "Edit Educategory Page"
    @educategory = Educategory.find(params[:id])
  end
  
  def create
    @educategory = Educategory.new(params[:educategory])
    if @educategory.save
      redirect_to(:url => admin_educategory_path(@educategory), :notice => 'Create Educategory Page Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @educategory = Educategory.find(params[:id])
    @educategory.last_updated_by = session[:admin_username]
    if @educategory.update_attributes(params[:educategory].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_educategory_path, :notice => 'Update Educategory Page Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @educategory = Educategory.find(params[:id])
    @educategory.destroy
    
    redirect_to(admin_educategories_path)
  end
  
end
