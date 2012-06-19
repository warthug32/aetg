class Admin::HotelsController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @hotels = Hotel.all#.paginate(:page => params[:page])
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "Hotels Management"
  end
  
  def index
    session[:current_page_name] = 'Hotels'
    @hotels = Hotel.all#.paginate(:page => params[:page])
  end
  
  def show
    #@user = User.find(params[:id])
    @hotels = Hotel.all#.paginate(:page => params[:page])
    render :action => "index"
  end
  
  def new
    @title = "Add Hotel"
    @hotels = Hotel.new
  end
  
  def edit
    @title = "Edit Hotel"
    @hotels = Hotel.find(params[:id])
  end
  
  def create
    @hotels = Hotel.new(params[:hotels])
    if @hotels.save
      redirect_to(:url => admin_hotel_path(@hotels), :notice => 'Create Hotel Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @hotels = Hotel.find(params[:id])
    @hotels.last_updated_by = session[:admin_username]
    if @hotels.update_attributes(params[:hotels].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_hotel_path, :notice => 'Update Hotel Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @hotels = Hotel.find(params[:id])
    @hotels.destroy
    
    redirect_to(admin_hotels_path)
  end
end
