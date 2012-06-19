class HomeController < ApplicationController
  include MainModule
  
  before_filter :set_title, :set_locale
  layout "home"
  I18n.default_locale = :en
  
  add_breadcrumb "Home", :root_path
  
  def set_title
    @title = ""
  end
  
  def change_locale
    I18n.locale = params[:locale]
    @job_posts = []
    @main = Page.where(:activate => true, :locale => I18n.locale, :page_url => 'home').limit(1).first
    #render :json => @home.banner_file_name
    @allpages = Page.where(:activate => true, :locale => I18n.locale).order("display_order")
    @partners = Partner.where(:activate => true).order("id")
    @opportunities = JobIndustry.where(:locale => I18n.locale).limit(7).order("created_at")
    @opportunities.each do |o|
      @posting = JobPost.where(:locale => I18n.locale, :job_industry_id => o.id).order('created_at')
      unless @posting.blank?
        @job_posts << {:id => o.id, :name => o.name, :count => @posting.count, :created => @posting[0].created_at.strftime('%d %b, %Y')}    
      end  
    end
    render :action => 'index'
  
    
  end
  
  
  def index
    # @meta = Seo.first#.paginate(:page => params[:page])
    @job_posts = []
    @main = Page.where(:activate => true, :locale => I18n.locale, :page_url => 'home').limit(1).first
    #render :json => @home.banner_file_name
    @allpages = Page.where(:activate => true, :locale => I18n.locale).order("display_order")
    @partners = Partner.where(:activate => true).order("id")
    @opportunities = JobIndustry.where(:locale => I18n.locale).limit(7).order("created_at")
    @opportunities.each do |o|
      @posting = JobPost.where(:locale => I18n.locale, :job_industry_id => o.id).order('created_at')
      unless @posting.blank?
        @job_posts << {:id => o.id, :name => o.name, :count => @posting.count, :created => @posting[0].created_at.strftime('%d %b, %Y')}    
      end  
    end
    
    #render :json => @job_posts
    # @banners = Banner.where(:activate => true, :locale => I18n.locale )
    # @topbanner = Topbanner.where(:activate => true, :locale => I18n.locale ).limit(1).first
    # conditions = {}
    # conditions[:activate] = true
    # @video = ProjectVideo.find(:all, :conditions => conditions, :order => "RAND()", :limit => 1).first
#     
    # @news = New.where(:activate => true, :locale => I18n.locale).limit(5)
#     
    # @highlight_article = Article.where(:activate => true, :locale => I18n.locale, :highlight => true).limit(2)
    # @highlight_event = Event.where(:activate => true, :locale => I18n.locale, :highlight => true).limit(2)
    # @highlight_new = New.where(:activate => true, :locale => I18n.locale, :highlight => true).limit(2)
#     
    # @publication = Article.where(:activate => true, :locale => I18n.locale).limit(6)
#     
    # @home_block = Page.where(:page_url => 'home-block').first
#     
    # @body_css = 'home'
  end
  
  def culture
    @meta = Seo.first#.paginate(:page => params[:page])
    @allpages = Page.where(:activate => true, :locale => I18n.locale).order("display_order")
    @topbanner = Topbanner.where(:activate => true, :locale => I18n.locale ).limit(1).first
    
    @cultures = Article.where(:activate => true, :locale => I18n.locale, :article_category_id => 1 ).limit(13)
    
    @body_css = 'culture'
    add_breadcrumb "Local Cultures", "/local-cultures"
  end
  
  def creativity
    @meta = Seo.first#.paginate(:page => params[:page])
    @allpages = Page.where(:activate => true, :locale => I18n.locale).order("display_order")
    @topbanner = Topbanner.where(:activate => true, :locale => I18n.locale ).limit(1).first
    
    @tags = Page.tag_counts_on(:tags)
    @creativity = Article.where(:activate => true, :locale => I18n.locale, :article_category_id => 1 ).limit(8)
    
    @body_css = 'creativity'
    add_breadcrumb "Creativity in Education", "/creativity-in-education"
  end
  
  def show
    #@user = User.find(params[:id])
    @allpages = Page.where(:activate => true, :locale => I18n.locale).order("display_order")
    @page = Page.where(:activate => true, :page_url => params[:page_url], :locale => I18n.locale).limit(1).first
    @page = @page.pages[0]
    render :json => @page
    #@meta = Seo.first
    
    #@title = @page.browser_title + ' | '
    
    
    # @tags = Page.tag_counts_on(:tags)
    # temp = []
    # @tempPage = @page
#     
    # temp << @page
    # while @tempPage.page_id != nil 
      # @tempPage = Page.find(@tempPage.page_id)
      # temp << @tempPage
    # end
#     
    # for tp in temp.reverse
      # add_breadcrumb tp.page_title, "/#{tp.page_url}"
    # end
#     
    # @sidenav_parent = temp.reverse[0]
#     
    # render :layout => @page.design_template
    
    #render :action => "index"
  end
  
  def tag_cloud
    @tags = Page.tag_counts_on(:tags)
  end
end
