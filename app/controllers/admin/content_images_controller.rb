class Admin::ContentImagesController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @content_images = ContentImage.all#.paginate(:page => params[:page])
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "Content Images Management"
  end
  
  def index
    session[:current_page_name] = 'content_images'
    @content_images = ContentImage.all#.paginate(:page => params[:page])
  end
  
  def show
    #@user = User.find(params[:id])
    @content_images = ContentImage.all#.paginate(:page => params[:page])
    render :action => "index"
  end
  
  def new
    @title = "Add Content Image"
    @content_images = ContentImage.new
  end
  
  def edit
    @title = "Edit Content Image"
    @content_images = ContentImage.find(params[:id])
  end
  
  def create
    @content_images = ContentImage.new(params[:content_images])
    if @content_images.save
      redirect_to(:url => admin_content_image_path(@content_images), :notice => 'Create Content Image Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @content_images = ContentImage.find(params[:id])
    @content_images.last_updated_by = session[:admin_username]
    if @content_images.update_attributes(params[:content_images].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_content_image_path, :notice => 'Update Content Image Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @content_images = ContentImage.find(params[:id])
    @content_images.destroy
    
    redirect_to(admin_content_images_path)
  end
end
