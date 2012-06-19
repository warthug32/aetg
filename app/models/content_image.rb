class ContentImage < ActiveRecord::Base
  require 'iconv'
  has_attached_file :content_image, :styles => { 
      :large => "700x400#", 
      :medium => "160x160",
      :thumb => "67x67>"
    },
  :url  => "/images/content_images/:id/:style/:basename.:extension",
  :path => ":rails_root/public/images/content_images/:id/:style/:basename.:extension",
  :default_url => '/images/frontend/banner-noimg.png',
  :default_style => :medium
  
  belongs_to :page
  
  before_post_process :transliterate_file_name
  
  def transliterate_file_name
    extension = File.extname(content_image.original_filename).gsub(/^\.+/, '')
    filename = content_image.original_filename.gsub(/\.#{extension}$/, '')
    self.content_image.instance_write(:file_name, "#{transliterate(filename)}.#{transliterate(extension)}")
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
