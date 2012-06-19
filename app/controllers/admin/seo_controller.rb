class Admin::SeoController < ApplicationController
  include Admin::AdministratorModule
  before_filter :set_title
  
  def set_title
    @title = "SEO Management"
  end
  
  def show
    @seo = Seo.find(1)
    render :action => "edit"
  end
  
  def edit
    @title = "Edit SEO Setting"
    @seo = Seo.find(params[:id])
  end
  
  def update
    @seo = Seo.find(params[:id])
    
    if @seo.update_attributes(params[:seo].reject{|k,v| v.blank?})
      
      redirect_to(:url => edit_admin_seo_path(1), :notice => 'Update Setting Successfully!')
    else
      render :action => "edit"
    end
  end
  
end
