class Members::RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, :only => [ :new, :create, :cancel ]
  prepend_before_filter :authenticate_scope!, :only => [:edit, :update, :destroy]
  
  include MainModule
  
  before_filter :set_title, :get_tag
  add_breadcrumb "Home", :root_path
  
  def set_title
    @title = "Sign Up"
  end
  
  def get_tag
    @tags = Page.tag_counts_on(:tags)
  end
  
  def new
      add_breadcrumb "Sign Up", '/members/sign_up?type=1'
      if params[:type] == '1'
        session[:reg_type] = 'Individual'
      elsif params[:type] == '2'
        session[:reg_type] = 'Organization'
      elsif params[:type] == '3'
        session[:reg_type] = 'Partners'
      end
      
      resource = build_resource({})
   
      respond_with resource
  end
  
  def create
      build_resource
      resource.role = session[:reg_type]
      
      if resource.save
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_navigational_format?
          sign_in(resource_name, resource)
          respond_with resource, :location => after_sign_up_path_for(resource)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
          expire_session_data_after_sign_in!
          respond_with resource, :location => after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        respond_with resource
      end
    end
    
    

  def after_inactive_sign_up_path_for(resource)
    "/awaiting_confirmation?email=#{resource.email}"
  end
  
  # GET /resource/edit
   def edit
     add_breadcrumb "Edit Profile", '/members/edit'
     @title = "Edit Profile"
     render :edit
   end

   # PUT /resource
   # We need to use a copy of the resource because we don't want to change
   # the current user in place.
   def update
     self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

     if resource.update_with_password(params[resource_name])
       if is_navigational_format?
         if resource.respond_to?(:pending_reconfirmation?) && resource.pending_reconfirmation?
           flash_key = :update_needs_confirmation
         end
         set_flash_message :notice, flash_key || :updated
       end
       sign_in resource_name, resource, :bypass => true
       respond_with resource, :location => after_update_path_for(resource)
     else
       clean_up_passwords resource
       respond_with resource
     end
   end
  
end