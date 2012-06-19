class Admin::JobIndustriesController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:new, :create, :destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @job_industry = JobIndustry.all
      redirect_to(:action => "index", :warning => 'You are not allowed to do this action!')
    end
  end
  
  def set_title
    @title = "Job Industries Management"
  end
  
  def index
    session[:current_page_name] = 'job_industries'
    @job_industry = JobIndustry.all
  end
  
  def show
    #@user = User.find(params[:id])
    @job_industry = JobIndustry.all
    render :action => "index"
  end
  
  def new
    @title = "Add Job Industry"
    @job_industry = JobIndustry.new
  end
  
  def edit
    @title = "Edit Job Industry"
    @job_industry = JobIndustry.find(params[:id])
  end
  
  def create
    @job_industry = JobIndustry.new(params[:job_industry])
    if @job_industry.save
      redirect_to(:url => admin_job_industry_path(@job_industry), :notice => 'Create Job Industry Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @job_industry = JobIndustry.find(params[:id])
    @job_industry.last_updated_by = session[:admin_username]
    if @job_industry.update_attributes(params[:job_industry].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_job_industry_path, :notice => 'Update Job Industry Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @job_industry = JobIndustry.find(params[:id])
    @job_industry.destroy
    
    redirect_to(admin_job_industries_path)
  end
end
