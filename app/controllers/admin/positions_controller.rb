class Admin::PositionsController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:new, :create, :destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @position = Position.all
      redirect_to(:action => "index", :warning => 'You are not allowed to do this action!')
    end
  end
  
  def set_title
    @title = "Positions Management"
  end
  
  def index
    session[:current_page_name] = 'Positions'
    @position = Position.all
  end
  
  def show
    #@user = User.find(params[:id])
    @position = Position.all
    render :action => "index"
  end
  
  def new
    @title = "Add Position"
    @position = Position.new
  end
  
  def edit
    @title = "Edit a Position"
    @position = Position.find(params[:id])
  end
  
  def create
    @position = Position.new(params[:position])
    if @position.save
      redirect_to(:url => admin_position_path(@position), :notice => 'Create Position Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @position = Position.find(params[:id])
    @position.last_updated_by = session[:admin_username]
    if @position.update_attributes(params[:position].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_position_path, :notice => 'Update Position Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @position = Position.find(params[:id])
    @position.destroy
    
    redirect_to(admin_positions_path)
  end
end
