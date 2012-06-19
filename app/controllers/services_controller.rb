class ServicesController < ApplicationController
  include MainModule
  
  before_filter :set_title, :set_locale
  layout "home"
  I18n.default_locale = :en
  
  
  def set_title
    @title = "Our Services"
  end
  
  def set_locale
    if params[:locale] == nil
      if session[:locale] == nil
        session[:locale] = "en"
      end
    else
      session[:locale] = params[:locale]
    end
    
    I18n.locale = session[:locale]
  end
  
  def show
    @allpages = Page.where(:activate => true, :locale => I18n.locale).order("display_order")
    @main = Page.where(:activate => true, :page_url => 'our_services', :locale => I18n.locale).limit(1).first
    
    #@content_images = ContentImage.where(:parent => @main.id).order("display_order")
  end
end
