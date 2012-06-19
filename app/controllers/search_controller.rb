class SearchController < ApplicationController
  
  def index
    if params[:search] != "" and params[:search] != "search"
      @results = Article.search(params[:search])
      @news_results = New.search(params[:search])
      @event_results = Event.search(params[:search])
      @member_results = Member.search(params[:search])
    end
    
    
    respond_to do |format|  
        format.html
        format.js  
    end
  end
end
