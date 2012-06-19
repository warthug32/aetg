class Admin::ProjectsController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @projects = Project.all#.paginate(:page => params[:page])
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "Projects Management"
  end
  
  def index
    session[:current_page_name] = 'Projects'
    @projects = Project.all#.paginate(:page => params[:page])
  end
  
  def show
    #@user = User.find(params[:id])
    @projects = Project.all#.paginate(:page => params[:page])
    render :action => "index"
  end
  
  def new
    @title = "Add Project"
    @projects = Project.new
  end
  
  def edit
    @title = "Edit Project"
    @projects = Project.find(params[:id])
  end
  
  def create
    @projects = Project.new(params[:projects])
    if @projects.save
      redirect_to(:url => admin_project_path(@projects), :notice => 'Create Project Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @projects = Project.find(params[:id])
    @projects.last_updated_by = session[:admin_username]
    if @projects.update_attributes(params[:projects].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_project_path, :notice => 'Update Project Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @projects = Project.find(params[:id])
    @projects.destroy
    
    redirect_to(admin_projects_path)
  end
end

