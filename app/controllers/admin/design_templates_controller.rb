class Admin::DesignTemplatesController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:new, :create, :destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @design_template = DesignTemplate.all#.paginate(:page => params[:page])
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "Design Template Management"
  end
  
  def index
    session[:current_page_name] = 'Design Templates'
    @design_template = DesignTemplate.all#.paginate(:page => params[:page])
  end
  
  def show
    #@user = User.find(params[:id])
    @design_template = DesignTemplate.all#.paginate(:page => params[:page])
    render :action => "index"
  end
  
  def new
    @title = "Add Design Template"
    @design_template = DesignTemplate.new
  end
  
  def edit
    @title = "Edit Design Template"
    @design_template = DesignTemplate.find(params[:id])
  end
  
  def create
    @design_template = DesignTemplate.new(params[:design_template])
    if @design_template.save
      redirect_to(:url => admin_design_template_path(@design_template), :notice => 'Create Design Template Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @design_template = DesignTemplate.find(params[:id])
    @design_template.last_updated_by = session[:admin_username]
    if @design_template.update_attributes(params[:design_template].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_design_template_path, :notice => 'Update Design Template Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @design_template = DesignTemplate.find(params[:id])
    @design_template.destroy
    
    redirect_to(admin_design_templates_path)
  end
  
end
