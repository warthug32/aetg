class Admin::ProjectVideosController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @project_videos = ProjectVideo.all#.paginate(:page => params[:page])
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "Project Videos Management"
  end
  
  def index
    session[:current_page_name] = 'Project Videos'
    @project_videos = ProjectVideo.all#.paginate(:page => params[:page])
  end
  
  def show
    #@user = User.find(params[:id])
    @project_videos = ProjectVideo.all#.paginate(:page => params[:page])
    render :action => "index"
  end
  
  def new
    @title = "Add Project Video"
    @project_videos = ProjectVideo.new
  end
  
  def edit
    @title = "Edit Project Video"
    @project_videos = ProjectVideo.find(params[:id])
  end
  
  def create
    @project_videos = ProjectVideo.new(params[:project_videos])
    if @project_videos.save
      redirect_to(:url => admin_project_video_path(@project_videos), :notice => 'Create Project Video Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @project_videos = ProjectVideo.find(params[:id])
    @project_videos.last_updated_by = session[:admin_username]
    if @project_videos.update_attributes(params[:project_videos].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_project_video_path, :notice => 'Update Project Video Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @project_videos = ProjectVideo.find(params[:id])
    @project_videos.destroy
    
    redirect_to(admin_project_videos_path)
  end
end
