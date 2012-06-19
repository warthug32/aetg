class Admin::PartnersController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @partners = Partner.all#.paginate(:page => params[:page])
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "Partners Management"
  end
  
  def index
    session[:current_page_name] = 'Partners'
    @partners = Partner.all#.paginate(:page => params[:page])
  end
  
  def show
    #@user = User.find(params[:id])
    @partners = Partner.all#.paginate(:page => params[:page])
    render :action => "index"
  end
  
  def new
    @title = "Add Partner"
    @partners = Partner.new
  end
  
  def edit
    @title = "Edit Partner"
    @partners = Partner.find(params[:id])
  end
  
  def create
    @partners = Partner.new(params[:partners])
    if @partners.save
      redirect_to(:url => admin_partner_path(@partners), :notice => 'Create Partner Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @partners = Partner.find(params[:id])
    @partners.last_updated_by = session[:admin_username]
    if @partners.update_attributes(params[:partners].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_partner_path, :notice => 'Update Partner Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @partners = Partner.find(params[:id])
    @partners.destroy
    
    redirect_to(admin_partners_path)
  end
end
