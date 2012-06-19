class Admin::EventsController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:new, :create, :destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @event = Event.all#.paginate(:page => params[:page])
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "Event Page Management"
  end
  
  def index
    session[:current_page_name] = 'Events'
    @event = Event.all#.paginate(:page => params[:page])
  end
  
  def show
    #@user = User.find(params[:id])
    @event = Event.all#.paginate(:page => params[:page])
    render :action => "index"
  end
  
  def new
    @title = "Add Event Page"
    @event = Event.new
  end
  
  def edit
    @title = "Edit Event Page"
    @event = Event.find(params[:id])
  end
  
  def create
    @event = Event.new(params[:event])
    @event.browser_url = transliterate(@event.title)
    if @event.save
      redirect_to(:url => admin_event_path(@event), :notice => 'Create Event Page Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @event = Event.find(params[:id])
    @event.browser_url = transliterate(@event.title)
    @event.last_updated_by = session[:admin_username]
    if @event.update_attributes(params[:event].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_event_path, :notice => 'Update Event Page Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    
    redirect_to(admin_events_path)
  end
  
end
