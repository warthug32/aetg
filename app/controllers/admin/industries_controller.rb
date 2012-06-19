class Admin::IndustriesController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:new, :create, :destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @industry = Industry.all#.paginate(:page => params[:page])
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "Industry Page Management"
  end
  
  def index
    session[:current_page_name] = 'Industries'
    @industry = Industry.all#.paginate(:page => params[:page])
  end
  
  def show
    #@user = User.find(params[:id])
    @industry = Industry.all#.paginate(:page => params[:page])
    render :action => "index"
  end
  
  def new
    @title = "Add Industry Page"
    @industry = Industry.new
  end
  
  def edit
    @title = "Edit Industry Page"
    @industry = Industry.find(params[:id])
  end
  
  def create
    @industry = Industry.new(params[:industry])
    if @industry.save
      redirect_to(:url => admin_industry_path(@industry), :notice => 'Create Industry Page Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @industry = Industry.find(params[:id])
    @industry.last_updated_by = session[:admin_username]
    if @industry.update_attributes(params[:industry].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_industry_path, :notice => 'Update Industry Page Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @industry = Industry.find(params[:id])
    @industry.destroy
    
    redirect_to(admin_industries_path)
  end
  
end
