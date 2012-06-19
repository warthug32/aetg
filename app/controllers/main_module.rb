module MainModule
  
  def self.included(base)
    I18n.default_locale = "en"
    base.before_filter :set_locale#, :open_enquiry
    
  end
  
  def open_enquiry
    #@enquiry = Enquiry.new
    session[:enquiry_type] = 'General'
  end
  
  def set_locale
    # if params[:locale] is nil then I18n.default_locale will be used
    if params[:locale] == nil
      if session[:locale] == nil
        session[:locale] = "en"
      end
    else
      session[:locale] = params[:locale]
    end
    
    I18n.locale = session[:locale]
    
  end
  
  def resp_body(body, content_type = "application/json")
    render :text => pretty_json(body), :content_type => content_type
  end
  
  
  def pretty_json(content)
     JSON.pretty_generate(content)
  end
  
end