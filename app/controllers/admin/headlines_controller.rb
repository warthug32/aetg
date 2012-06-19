class Admin::HeadlinesController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  
  def set_title
    @title = "News Management"
  end
  
  def index
    session[:current_page_name] = 'News'
    @news = New.all#.paginate(:page => params[:page])
  end
  
  def show
    #@user = User.find(params[:id])
    @news = New.all#.paginate(:page => params[:page])
    render :action => "index"
  end
  
  def new
    @title = "Add News"
    @news = New.new
  end
  
  def edit
    @title = "Edit News"
    @news = New.find(params[:id])
  end
  
  def create
    @news = New.new(params[:news])
    @news.browser_url = transliterate(@news.title)
    if @news.save
      redirect_to(:url => admin_headline_path(@news), :notice => 'Create News Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @news = New.find(params[:id])
    @news.browser_url = transliterate(@news.title)
    @news.last_updated_by = session[:admin_username]
    if @news.update_attributes(params[:news].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_headline_path, :notice => 'Update News Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @news = New.find(params[:id])
    @news.destroy
    
    redirect_to(admin_headlines_path)
  end
end