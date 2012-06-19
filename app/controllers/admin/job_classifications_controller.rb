class Admin::JobClassificationsController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:new, :create, :destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @job_classification = JobClassification.all
      redirect_to(:action => "index", :warning => 'You are not allowed to do this action!')
    end
  end
  
  def set_title
    @title = "Job Classifications Management"
  end
  
  def index
    session[:current_page_name] = 'job_classifications'
    @job_classification = JobClassification.all
  end
  
  def show
    #@user = User.find(params[:id])
    @job_classification = JobClassification.all
    render :action => "index"
  end
  
  def new
    @title = "Add Job Classification"
    @job_classification = JobClassification.new
  end
  
  def edit
    @title = "Edit Job Classification"
    @job_classification = JobClassification.find(params[:id])
  end
  
  def create
    @job_classification = JobClassification.new(params[:job_classification])
    if @job_classification.save
      redirect_to(:url => admin_job_classification_path(@job_classification), :notice => 'Create Job Classification Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @job_classification = JobClassification.find(params[:id])
    @job_classification.last_updated_by = session[:admin_username]
    if @job_classification.update_attributes(params[:job_classification].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_job_classification_path, :notice => 'Update Job Classification Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @job_classification = JobClassification.find(params[:id])
    @job_classification.destroy
    
    redirect_to(admin_job_classifications_path)
  end
end
