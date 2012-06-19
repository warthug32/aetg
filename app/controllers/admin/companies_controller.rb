class Admin::CompaniesController < ApplicationController
  
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:new, :create, :destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @company = Company.all
      redirect_to(:action => "index", :warning => 'You are not allowed to do this action!')
    end
  end
  
  def set_title
    @title = "Companies Management"
  end
  
  def index
    session[:current_page_name] = 'Companies'
    @company = Company.all
  end
  
  def show
    #@user = User.find(params[:id])
    @company = Company.all
    render :action => "index"
  end
  
  def new
    @title = "Add Company"
    @company = Company.new
  end
  
  def edit
    @title = "Edit a Company"
    @company = Company.find(params[:id])
  end
  
  def create
    @company = Company.new(params[:company])
    if @company.save
      redirect_to(:url => admin_company_path(@company), :notice => 'Create Company Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @company = Company.find(params[:id])
    @company.last_updated_by = session[:admin_username]
    if @company.update_attributes(params[:company].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_company_path, :notice => 'Update Company Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    
    redirect_to(admin_companies_path)
  end
end
