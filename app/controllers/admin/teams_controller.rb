class Admin::TeamsController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:new, :create, :destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @team = Team.all
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "Teams Management"
  end
  
  def index
    session[:current_page_name] = 'Teams'
    @team = Team.all
  end
  
  def show
    #@user = User.find(params[:id])
    @team = Team.all
    render :action => "index"
  end
  
  def new
    @title = "Add Team Member"
    @team = Team.new
  end
  
  def edit
    @title = "Edit a Team Member"
    @team = Team.find(params[:id])
  end
  
  def create
    @team = Team.new(params[:team])
    if @team.save
      redirect_to(:url => admin_team_path(@team), :notice => 'Create Team Member Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @team = Team.find(params[:id])
    @team.last_updated_by = session[:admin_username]
    if @team.update_attributes(params[:team].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_team_path, :notice => 'Updated Team Member Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    
    redirect_to(admin_teams_path)
  end
end
