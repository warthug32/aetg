class EnquiriesController < ApplicationController
  respond_to :html, :xml, :json
  
  def new
    @enquiry = Enquiry.new
  end
  
  def create
    @enquiry = Enquiry.new(params[:enquiry])
    
    if @enquiry.save
      UserMailer.enquiry_email(@enquiry).deliver
    
      render :controller => 'home', :action => 'index'
    else
      render :action => 'new'
    end
  end
end
