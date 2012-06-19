class Admin::UsersController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:new, :edit, :create, :update, :destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @user = User.all#.paginate(:page => params[:page])
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "Users Management"
  end
  
  def index
    session[:current_page_name] = 'Users'
    @user = User.all#.paginate(:page => params[:page])
  end
  
  def show
    #@user = User.find(params[:id])
    @user = User.all#.paginate(:page => params[:page])
    render :action => "index"
  end
  
  def new
    @title = "Add User"
    @user = User.new
  end
  
  def edit
    @title = "Edit User"
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to(:url => admin_user_path(@user), :notice => 'Create User Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_user_path, :notice => 'Update User Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    redirect_to(admin_users_url)
  end

  
  
end
