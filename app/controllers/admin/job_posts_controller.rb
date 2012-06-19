class Admin::JobPostsController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:new, :create, :destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @job_post = JobPost.all#.paginate(:page => params[:job_post])
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "Job Post Management"
  end
  
  def index
    session[:current_page_name] = 'job_posts'
    @job_post = JobPost.all#.paginate(:page => params[:job_post])
  end
  
  def show
    #@user = User.find(params[:id])
    @job_post = JobPost.all#.paginate(:page => params[:job_post])
    render :action => "index"
  end
  
  def new
    @title = "Add Job Post"
    @job_post = JobPost.new
  end
  
  def edit
    @title = "Edit Job Post"
    @job_post = JobPost.find(params[:id])
  end
  
  def create
    @job_post = JobPost.new(params[:job_post])
    if @job_post.save
      redirect_to(:url => admin_job_post_path(@job_post), :notice => 'Create Job Post Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @job_post = JobPost.find(params[:id])
    @job_post.last_updated_by = session[:admin_username]
    if @job_post.update_attributes(params[:job_post].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_job_post_path, :notice => 'Update Job Post Successfully!')
    else
      #flash[:warning] = @job_post.errors
      render :action => "edit"
    end
  end

  def destroy
    @job_post = JobPost.find(params[:id])
    @job_post.destroy
    
    redirect_to(admin_job_posts_path)
  end
end
