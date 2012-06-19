Aetg::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  
  namespace :admin do
     root :to => "portal#index"
     match 'login' => 'portal#login'
     #match 'authenticate' => 'portal#authenticate'
     match 'logout' => 'portal#logout', :as => 'logout_admin_user'
     match 'dashboard' => 'portal#index'
     resources :users
     match 'users/new' => 'users#new'
     resources :locales
     resources :seo
     # resources :projects
     # resources :project_images
     # resources :project_videos
     match 'project_images/:id/project' => 'project_images#specific_project'
     match 'project_videos/:id/project' => 'project_videos#specific_project'

     # resources :product_categories
     # resources :products
     # resources :comments
     # resources :contacts
     # resources :abouts
     # resources :banners
     resources :topbanners
     
     resources :pages
     resources :design_templates
     resources :branches
     #resources :headlines
     #resources :events
     #resources :articles
     #resources :article_categories
     #resources :industries
     #resources :natures
     #resources :educategories
     resources :partners
     resources :teams
     resources :content_images
     resources :job_posts
     resources :companies
     resources :job_industries
     resources :job_classifications
     resources :job_posts
     resources :positions
   end
   
    devise_for :members, :controllers => {  :registrations => "members/registrations", :sessions => "members/sessions"} #,:unlocks => "members/unlocks", :passwords => "members/passwords", :confirmations => "members/confirmations", :omniauth_callbacks => "members/omniauth_callbacks" }
    
    match '/searchers' => 'search#index'
    match '/organization' => 'people#organization_index'
    match 'home' => 'home#index'
    match 'about_us' => 'about_us#show'
    match 'about_us/:page_url' => 'about_us#show'
    match 'our_services' => 'services#show'
    match 'our_team' => 'teams#index'
    match 'our_team/:page_url' => 'teams#show'
    match 'our_practices' => 'practices#show'
    match 'our_practices/(:page_url)' => 'practices#show', :constraints => { :page_url => /.*/ }
    match 'our_stories' => 'stories#show'
    match 'our_stories/:page_url' => 'stories#show'
    match 'our_advantages' => 'advantages#show'
    match 'our_advantages/:page_url' => 'advantages#show'
    match 'opportunities' => 'opportunities#list', :as => 'job_posts'
    match 'opportunities/show/:id' => 'opportunities#show'
    match 'opportunities/display/:id' => 'opportunities#display'
    match 'opportunities/industry/:industry_id' => 'opportunities#browse'
    match 'contact_us' => 'contact_us#show'
    #match 'about_us/vision' => 'about_us#vision'
    #match 'about_us/mission' => 'about_us#mission'
    #match 'about_us/values' => 'about_us#values'
      #resources :articles
      #match 'local-cultures' => 'home#culture'
      # match 'creativity-in-education' => 'home#creativity'
      # match 'worldwide-events-Map' => 'maps#index', :as => 'map'
      # match 'news/:id/:browser_url' => 'headlines#show'
      # match 'news-and-events' => 'headlines#latest'
      # match 'news' => 'headlines#index'
      # match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
      # match 'events/:id/:browser_url' => 'events#show'
# 
# 
      # match '/publications/:id/:browser_url' => 'publications#show'
      # match '/publications/:browser_url' => 'publications#index'
# 
#       
      # match ':page_url' => 'home#show'
      
      
   scope ':locale' do
    
   end
   
   
   root :to => 'home#index'
   match '/:locale' => 'home#change_locale'
end

