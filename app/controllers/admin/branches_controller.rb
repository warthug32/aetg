class Admin::BranchesController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:new, :create, :destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @branch = Branch.all#.paginate(:page => params[:page])
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "Branch Page Management"
  end
  
  def index
    session[:current_page_name] = 'Branchs'
    @branch = Branch.all#.paginate(:page => params[:page])
  end
  
  def show
    #@user = User.find(params[:id])
    @branch = Branch.all#.paginate(:page => params[:page])
    render :action => "index"
  end
  
  def new
    @title = "Add Branch Page"
    @branch = Branch.new
  end
  
  def edit
    @title = "Edit Branch Page"
    @branch = Branch.find(params[:id])
  end
  
  def create
    @branch = Branch.new(params[:branch])
    if @branch.save
      redirect_to(:url => admin_branch_path(@branch), :notice => 'Create Branch Page Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @branch = Branch.find(params[:id])
    if @branch.update_attributes(params[:branch].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_branch_path, :notice => 'Update Branch Page Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @branch = Branch.find(params[:id])
    @branch.destroy
    
    redirect_to(admin_branches_path)
  end
  
end
