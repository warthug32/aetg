class Page < ActiveRecord::Base
  require 'iconv'
  acts_as_taggable
  
  has_many :pages
  has_many :content_images
  
  has_attached_file :banner, :styles => {  
      :large => "960x260#"
    },
  :url  => "/images/pages/:id/:style/:basename.:extension",
  :path => ":rails_root/public/images/pages/:id/:style/:basename.:extension",
  :default_url => '/images/frontend/page-banner-noimg.png',
  :default_style => :medium
  
  before_post_process :transliterate_file_name
  
  def transliterate_file_name
    extension = File.extname(banner.original_filename).gsub(/^\.+/, '')
    filename = banner.original_filename.gsub(/\.#{extension}$/, '')
    self.banner.instance_write(:file_name, "#{transliterate(filename)}.#{transliterate(extension)}")
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
