class AboutUsController < ApplicationController
  
  include MainModule
  
  before_filter :set_title, :set_locale
  layout "home"
  I18n.default_locale = :en
  
  
  def set_title
    @title = ""
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
    @page_url = params[:page_url] || 'message'
    @allpages = Page.where(:activate => true, :locale => I18n.locale).order("display_order")
    @main = Page.where(:activate => true, :page_url => 'about_us', :locale => I18n.locale).limit(1).first
    @current_page = Page.where(:activate => true, :page_url => @page_url, :page_id => @main.id, :locale => I18n.locale).limit(1).first
  end
  
    
end
