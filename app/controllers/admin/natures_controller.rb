class Admin::NaturesController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:new, :create, :destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @nature = Nature.all#.paginate(:page => params[:page])
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "Nature Page Management"
  end
  
  def index
    session[:current_page_name] = 'Natures'
    @nature = Nature.all#.paginate(:page => params[:page])
  end
  
  def show
    #@user = User.find(params[:id])
    @nature = Nature.all#.paginate(:page => params[:page])
    render :action => "index"
  end
  
  def new
    @title = "Add Nature Page"
    @nature = Nature.new
  end
  
  def edit
    @title = "Edit Nature Page"
    @nature = Nature.find(params[:id])
  end
  
  def create
    @nature = Nature.new(params[:nature])
    if @nature.save
      redirect_to(:url => admin_nature_path(@nature), :notice => 'Create Nature Page Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @nature = Nature.find(params[:id])
    @nature.last_updated_by = session[:admin_username]
    if @nature.update_attributes(params[:nature].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_nature_path, :notice => 'Update Nature Page Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @nature = Nature.find(params[:id])
    @nature.destroy
    
    redirect_to(admin_natures_path)
  end
  
end
