class Admin::ProductCategoriesController < ApplicationController
  
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @product_categories = ProductCategory.all#.paginate(:page => params[:page])
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "Product Category Management"
  end
  
  def index
    session[:current_page_name] = 'Product Category'
    @product_categories = ProductCategory.all#.paginate(:page => params[:page])
  end
  
  def show
    #@user = User.find(params[:id])
    @product_categories = ProductCategory.all#.paginate(:page => params[:page])
    render :action => "index"
  end
  
  def new
    @title = "Add Product Category"
    @product_categories = ProductCategory.new
  end
  
  def edit
    @title = "Edit Product Category"
    @product_categories = ProductCategory.find(params[:id])
  end
  
  def create
    @product_categories = ProductCategory.new(params[:product_categories])
    if @product_categories.save
      redirect_to(:url => admin_product_categories_path(@product_categories), :notice => 'Create Product Category Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @product_categories = ProductCategory.find(params[:id])
    @product_categories.last_updated_by = session[:admin_username]
    if @product_categories.update_attributes(params[:product_categories].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_product_categories_path, :notice => 'Update Product Category Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @product_categories = ProductCategory.find(params[:id])
    @product_categories.destroy
    
    redirect_to(admin_product_categories_path)
  end
end
  
