class Team < ActiveRecord::Base
  require 'iconv'
  
  has_attached_file :cover, :styles => {  
      :medium => "140x180#"
    },
  :url  => "/images/teams/:id/:style/:basename.:extension",
  :path => ":rails_root/public/images/teams/:id/:style/:basename.:extension",
  :default_url => '/images/frontend/page-banner-noimg.png',
  :default_style => :medium
  
  before_post_process :transliterate_file_name
  
  def transliterate_file_name
    extension = File.extname(cover.original_filename).gsub(/^\.+/, '')
    filename = cover.original_filename.gsub(/\.#{extension}$/, '')
    self.cover.instance_write(:file_name, "#{transliterate(filename)}.#{transliterate(extension)}")
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
