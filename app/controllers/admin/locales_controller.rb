class Admin::LocalesController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
 
  def set_title
    @title = "Languages Management"
  end
  
  def index
    session[:current_page_name] = 'Languages'
    @locale = Locale.all#.paginate(:page => params[:page])
  end
  
  def show
    @locale = Locale.all
    render :action => "index"
  end
  
  def new
    @title = "Add Language"
    @locale = Locale.new
  end
  
  def create
    @locale = Locale.new(params[:locale])
    if @locale.save
      redirect_to(:url => admin_locale_path(@locale), :notice => 'Create Language Successfully!')
    else
      render :action => "new"
    end
  end

  def destroy
    @locale = Locale.find(params[:id])
    @locale.destroy
    
    redirect_to(admin_locales_url)
  end
  
  
end
