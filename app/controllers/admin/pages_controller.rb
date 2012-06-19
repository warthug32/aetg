class Admin::PagesController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:new, :create, :destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @page = Page.all#.paginate(:page => params[:page])
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "Pages Management"
  end
  
  def index
    session[:current_page_name] = 'Pages'
    @page = Page.all#.paginate(:page => params[:page])
  end
  
  def show
    #@user = User.find(params[:id])
    @page = Page.all#.paginate(:page => params[:page])
    render :action => "index"
  end
  
  def new
    @title = "Add Page"
    @page = Page.new
  end
  
  def edit
    @title = "Edit Page"
    @page = Page.find(params[:id])
  end
  
  def create
    @page = Page.new(params[:page])
    @page.tag_list = @page.tag
    if @page.save
      redirect_to(:url => admin_page_path(@page), :notice => 'Create Page Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @page = Page.find(params[:id])
    @page.tag_list = @page.tag
    @page.last_updated_by = session[:admin_username]
    if @page.update_attributes(params[:page].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_page_path, :notice => 'Update Page Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    
    redirect_to(admin_pages_path)
  end
  
end
