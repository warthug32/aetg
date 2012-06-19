module Admin::AdministratorModule
  
  
  
  def self.included(base)
    base.before_filter :login_required
    base.layout "administrator"
    I18n.default_locale = :en
  end
  
  def login_required
    if(current_admin_user)
      return true
    elsif(cookies[:remember_me_id] and cookies[:remember_me_code] and User.exists?(cookies[:remember_me_id]) and Digest::SHA1.hexdigest(User.where(:id => cookies[:remember_me_id]).first.email)[4,18] == cookies[:remember_me_code])
      admin = User.find(cookies[:remember_me_id])  
      session['admin_user'] = admin.id
      session[:admin_username] = admin.username
      return true
    else
      if request.url != "/admin/login"
        session[:return_to_url] = request.url
      end
      redirect_to :controller => 'admin/portal', :action => "login"
     return false
   end
  end
  
  def set_en_locale
    I18n.default_locale = :en
  end
  
  def current_admin_user
    if session[:admin_user] != nil
      return true
    else
      return false
    end
  end
  
  def redirect_to_stored
    if return_to = session[:return_to_url]
      session[:return_to_url] = nil
      redirect_to(return_to)
    else
      redirect_to :controller => 'admin/portal', :action => "index"
    end
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