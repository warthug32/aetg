class ApplicationController < ActionController::Base
  protect_from_forgery
  
  layout 'signup'
  
  before_filter :get_meta_data, :get_menu
  
  def get_meta_data
    @meta = Seo.first
  end
  
  def get_menu
    @allpages = Page.where(:activate => true, :locale => I18n.locale).order("display_order")
  end
  
  def transliterate(str)
    s = Iconv.iconv('ascii//ignore//translit', 'utf-8', str).to_s
    s.downcase!
    s.gsub!(/'/, '')
    s.gsub!(/[^A-Za-z0-9]+/, ' ')
    s.strip!
    s.gsub!(/\ +/, '-')
    return s
  end
end
