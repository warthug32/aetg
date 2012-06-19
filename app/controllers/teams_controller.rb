class TeamsController < ApplicationController
  include MainModule
  
  before_filter :set_title, :set_locale
  layout "home"
  I18n.default_locale = :en
  
  
  def set_title
    @title = "Our Team"
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
  
  def index
    @title = 'Executive Team and Practice Leaders'
    @allpages = Page.where(:activate => true, :locale => I18n.locale).order("display_order")
    @main = Page.where(:activate => true, :page_url => 'our_team', :locale => I18n.locale).limit(1).first
    @teams = Team.where(:activate => true).order("display_order")
  end
  
  def show
    @allpages = Page.where(:activate => true, :locale => I18n.locale).order("display_order")
    @main = Page.where(:activate => true, :page_url => 'our_team', :locale => I18n.locale).limit(1).first
    @teams = Team.where(:activate => true).order("display_order")
    @member = Team.where(:activate => true, :page_url => params[:page_url]).limit(1).first
  end
end
