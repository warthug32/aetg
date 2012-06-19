class Admin::CommentsController < ApplicationController
  
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @comments = Comment.all#.paginate(:page => params[:page])
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "Comment Management"
  end
  
  def index
    session[:current_page_name] = 'Comments'
    @comments = Comment.where(:store_id => params[:store])#.paginate(:page => params[:page])
  end
  
  def show
    #@user = User.find(params[:id])
    @comments = Comment.all#.paginate(:page => params[:page])
    render :action => "index"
  end
  
  def new
    @title = "Add Comment"
    @comments = Comment.new
  end
  
  def edit
    @title = "Edit Comment"
    @comments = Comment.find(params[:id])
  end
  
  def create
    @comments = Comment.new(params[:comments])
    if @comments.save
      redirect_to(:url => admin_comment_path(@comments), :notice => 'Create Comment Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @comments = Comment.find(params[:id])
    #@comments.last_updated_by = session[:admin_username]
    if @comments.update_attributes(params[:comments].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_comment_path, :notice => 'Update Comment Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @comments = Comment.find(params[:id])
    @comments.destroy
    
    redirect_to(admin_comments_path)
  end
end
