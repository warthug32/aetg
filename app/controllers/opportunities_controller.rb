class OpportunitiesController < ApplicationController
  
  include MainModule
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TextHelper
  require 'will_paginate/array'
  
  before_filter :set_title, :set_locale
  layout "home"
  I18n.default_locale = :en
  
  
  def set_title
    @title = "Executive Opportunities"
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
  
  def list
    @job_posts = {}
    @sorting = params[:sortby] || 'created_at'
    @main = Page.where(:activate => true, :page_url => 'opportunities', :locale => I18n.locale).limit(1).first
    @allpages = Page.where(:activate => true, :locale => I18n.locale).order("display_order")
    @industry = JobIndustry.where(:locale => I18n.locale)
    unless params[:industry_id].nil? or params[:industry_id].blank?
      @posts = JobPost.where(:activate => true, :job_industry_id => params[:industry_id], :locale => I18n.locale).order(@sorting)
      @curr_industry = JobIndustry.where(:id => params[:industry_id], :locale => I18n.locale )
      @header_title = @curr_industry[0].name.upcase
      @industry_id =   @curr_industry[0].id
    else
      @posts = JobPost.where(:activate => true, :locale => I18n.locale).order(@sorting)
      @header_title = 'LIST OF JOB POSTINGS'
      @industry_id =   ''
    end
    @job_posts = @posts.map { |val|
                              @classification = JobClassification.where(:id => val.job_classification_id, :locale => I18n.locale)
                                { :id => val.id,
                                  :position => val.position,
                                  :description => val.description,
                                  :location => val.location,
                                  :date_posted => val.created_at.strftime("%d/%m/%y"),
                                  :salary1 => val.salary1,
                                  :salary2 => val.salary2,
                                  :classification => @classification[0].name 
                                }
                            }.paginate(:page => params[:page], :per_page => 3)
    #resp_body(@job_posts)                      
  end
  
  def show
    
    @sorting = params[:field_name] || 'created_at'
    @main = Page.where(:activate => true, :page_url => 'opportunities', :locale => I18n.locale).limit(1).first
    @allpages = Page.where(:activate => true, :locale => I18n.locale).order("display_order")
    @industry = JobIndustry.where(:locale => I18n.locale)
    @post = JobPost.where(:activate => true, :id => params[:id], :locale => I18n.locale).limit(1).first
    #render :json => @post
    
    # @worktype = WorkType.where(:id => @post.work_type).limit(1).first
    # render :json => @worktype.name
  end
  
  
  def browse
    
    @sorting = params[:field_name] || 'created_at'
    @main = Page.where(:activate => true, :page_url => 'opportunities', :locale => I18n.locale).limit(1).first
    @allpages = Page.where(:activate => true, :locale => I18n.locale).order("display_order")
    @industry = JobIndustry.where(:locale => I18n.locale)
    @posts = JobPost.where(:activate => true, :job_industry_id => params[:industry_id], :locale => I18n.locale).order(@sorting)
    @job_posts = @posts.map { |val|
                              @classification = JobClassification.where(:id => val.job_classification_id, :locale => I18n.locale)
                                { :id => val.id,
                                  :position => val.position,
                                  :description => val.description,
                                  :location => val.location,
                                  :date_posted => val.created_at.strftime("%d/%m/%y"),
                                  :salary1 => val.salary1,
                                  :salary2 => val.salary2,
                                  :classification => @classification[0].name 
                                }
                            }.paginate(:page => params[:page], :per_page => 3)
    #resp_body(@job_posts)                      
  end
  
  
  
  
end
