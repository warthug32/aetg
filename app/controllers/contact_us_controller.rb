class ContactUsController < ApplicationController
  include MainModule
  
  before_filter :set_title, :set_locale
  layout "home"
  I18n.default_locale = :en
  
  
  def set_title
    @title = "Contact Us"
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
    @main = Page.where(:activate => true, :page_url => 'contact_us', :locale => I18n.locale).limit(1).first
    @branches = Branch.where(:activate => true, :locale => I18n.locale).order("created_at")
    #render :json => @branches
    #@current_page = Page.where(:activate => true, :page_url => @page_url, :page_id => @main.id, :locale => I18n.locale).limit(1).first
  end
  
end
