class Admin::ArticlesController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:new, :create, :destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @article = Article.all#.paginate(:page => params[:page])
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "Article Page Management"
  end
  
  def index
    session[:current_page_name] = 'Articles'
    @article = Article.all#.paginate(:page => params[:page])
  end
  
  def show
    #@user = User.find(params[:id])
    @article = Article.all#.paginate(:page => params[:page])
    render :action => "index"
  end
  
  def new
    @title = "Add Article Page"
    @article = Article.new
  end
  
  def edit
    @title = "Edit Article Page"
    @article = Article.find(params[:id])
  end
  
  def create
    @article = Article.new(params[:article])
    @article.browser_url = transliterate(@article.title)
    if @article.save
      redirect_to(:url => admin_article_path(@article), :notice => 'Create Article Page Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @article = Article.find(params[:id])
    @article.last_updated_by = session[:admin_username]
    @article.browser_url = transliterate(@article.title)
    if @article.update_attributes(params[:article].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_article_path, :notice => 'Update Article Page Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    
    redirect_to(admin_articles_path)
  end
  
end
