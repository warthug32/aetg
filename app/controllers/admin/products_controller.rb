class Admin::ProductsController < ApplicationController
  
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @products = Product.all#.paginate(:page => params[:page])
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "Products Management"
  end
  
  def index
    session[:current_page_name] = 'Products'
    @products = Product.all#.paginate(:page => params[:page])
  end
  
  def show
    #@user = User.find(params[:id])
    @products = Product.all#.paginate(:page => params[:page])
    render :action => "index"
  end
  
  def new
    @title = "Add Product"
    @products = Product.new
  end
  
  def edit
    @title = "Edit Product"
    @products = Product.find(params[:id])
  end
  
  def create
    @products = Product.new(params[:products])
    if @products.save
      redirect_to(:url => admin_product_path(@products), :notice => 'Create Product Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @products = Product.find(params[:id])
    @products.last_updated_by = session[:admin_username]
    if @products.update_attributes(params[:products].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_product_path, :notice => 'Update Product Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @products = Product.find(params[:id])
    @products.destroy
    
    redirect_to(admin_products_path)
  end
end

