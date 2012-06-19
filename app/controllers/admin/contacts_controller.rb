class Admin::ContactsController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  before_filter :check_role, :only => [:new, :create, :destroy]

  def check_role
    if session[:admin_role] != 'Admin'
      @contact = Contact.all#.paginate(:page => params[:page])
      redirect_to(:action => "index", :warning => 'You are not allow to do this action!')
    end
  end
  
  def set_title
    @title = "Contact Us Page Management"
  end
  
  def index
    session[:current_page_name] = 'Contacts'
    @contact = Contact.all#.paginate(:page => params[:page])
  end
  
  def show
    #@user = User.find(params[:id])
    @contact = Contact.all#.paginate(:page => params[:page])
    render :action => "index"
  end
  
  def new
    @title = "Add Contact Us Page"
    @contact = Contact.new
  end
  
  def edit
    @title = "Edit Contact Us Page"
    @contact = Contact.find(params[:id])
  end
  
  def create
    @contact = Contact.new(params[:contact])
    if @contact.save
      redirect_to(:url => admin_contact_path(@contact), :notice => 'Create Contact Us Page Successfully!')
    else
      render :action => "new"
    end
  end
  
  def update
    @contact = Contact.find(params[:id])
    @contact.last_updated_by = session[:admin_username]
    if @contact.update_attributes(params[:contact].reject{|k,v| v.blank?})
      
      redirect_to(:url => admin_contact_path, :notice => 'Update Contact Us Page Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    
    redirect_to(admin_contacts_path)
  end
end
