class AdvantagesController < ApplicationController
  
  include MainModule
  
  before_filter :set_title, :set_locale
  layout "home"
  I18n.default_locale = :en
  
  
  def set_title
    @title = "Our Advantages"
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
    @page_url = params[:page_url] || 'experienced'
    @allpages = Page.where(:activate => true, :locale => I18n.locale).order("display_order")
    @main = Page.where(:activate => true, :page_url => 'our_advantages', :locale => I18n.locale).limit(1).first
    @current_page = Page.where(:activate => true, :page_url => @page_url, :page_id => @main.id, :locale => I18n.locale).limit(1).first
    #@content_images = ContentImage.where(:parent => @main.id).order("display_order")
    #@industry_practices = Page.where('page_url LIKE ?', 'industry_practice%').order("display_order")
    #@functional_practices = Page.where('page_url LIKE ?', 'functional_practice%').order("display_order")
    #render :json => @class
  end
end
