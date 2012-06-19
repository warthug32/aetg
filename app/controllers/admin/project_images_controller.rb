class Admin::ProjectImagesController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @project_images = ProjectImage.all#.paginate(:page => params[:page])
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "Project Images Management"
  end
  
  def index
    session[:current_page_name] = 'Project_Images'
    @project_images = ProjectImage.where(:project_id => session[:project_id])#.paginate(:page => params[:page])
  end
  
  def specific_project
    session[:project_id] = params[:id]
    @project_images = ProjectImage.where(:project_id => session[:project_id])
    render :action => "index"
  end
  
  def show
    #@user = User.find(params[:id])
    #@project_images = ProjectImage.all#.paginate(:page => params[:page])
    @project_images = ProjectImage.where(:project_id => session[:project_id])
    render :action => "index"
  end
  
  def new
    @title = "Add Project Image"
    @project_images = ProjectImage.new
  end
  
  def edit
    @title = "Edit Project Image"
    @project_images = ProjectImage.find(params[:id])
  end
  
  def create
    @project_images = ProjectImage.new(params[:project_images])
    @project_images.project_id = session[:project_id]
    if @project_images.save
      redirect_to(:url => admin_project_image_path(@project_images), :notice => 'Create Project Image Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @project_images = ProjectImage.find(params[:id])
    @project_images.last_updated_by = session[:admin_username]
    if @project_images.update_attributes(params[:project_images].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_project_image_path, :notice => 'Update Project Image Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @project_images = ProjectImage.find(params[:id])
    @project_images.destroy
    
    redirect_to(admin_project_images_path)
  end
end

