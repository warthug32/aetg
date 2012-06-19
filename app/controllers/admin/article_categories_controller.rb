class Admin::ArticleCategoriesController < ApplicationController

  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @article_categories = ArticleCategory.all#.paginate(:page => params[:page])
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "Article Category Management"
  end
  
  def index
    session[:current_page_name] = 'Article Category'
    @article_categories = ArticleCategory.all#.paginate(:page => params[:page])
  end
  
  def show
    #@user = User.find(params[:id])
    @article_categories = ArticleCategory.all#.paginate(:page => params[:page])
    render :action => "index"
  end
  
  def new
    @title = "Add Article Category"
    @article_categories = ArticleCategory.new
  end
  
  def edit
    @title = "Edit Article Category"
    @article_categories = ArticleCategory.find(params[:id])
  end
  
  def create
    @article_categories = ArticleCategory.new(params[:article_categories])
    if @article_categories.save
      redirect_to(:url => admin_article_categories_path(@article_categories), :notice => 'Create Article Category Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @article_categories = ArticleCategory.find(params[:id])
    @article_categories.last_updated_by = session[:admin_username]
    if @article_categories.update_attributes(params[:article_categories].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_article_categories_path, :notice => 'Update Article Category Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @article_categories = ArticleCategory.find(params[:id])
    @article_categories.destroy
    
    redirect_to(admin_article_categories_path)
  end
end
  
