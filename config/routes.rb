ActionController::Routing::Routes.draw do |map|
  map.resources :searches
  map.resources :friendships
  map.resources :bands
  map.resources :venues
  map.resources :users
  map.resources :shows
  map.resources :bands
  map.resources :locations
  map.resources :venues
  map.resources :comments
  map.resources :user_sessions

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action
  map.login 'login', :controller => 'user_sessions', :action => 'new'  
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'  
  map.connect 'signup', :controller => 'user', :action => 'new'
  map.about 'about', :controller => 'shows', :action => 'about'
  map.search 'search', :controller => 'search'
  map.resources :password_resets
  map.connect 'reset_password', :controller => 'password_resets', :action => 'new'
  map.connect 'password_resets', :controller => 'password_resets', :action => 'new'
  map.connect 'bands/:id/pictures', :controller => 'bands', :action => 'pictures'
  map.connect 'bands/:id/picture/:page', :controller => 'bands', :action => 'picture'
  map.connect 'locations/byState/:state', :controller => 'locations', :action =>'byState'
  map.connect 'shows/update_show_description', :controller => 'shows', :action => 'update_show_description'
  map.connect 'shows/new/possibleDuplicate', :controller => 'shows', :action => 'possibleDuplicate'
  map.connect 'newShow/stillpost/:answer', :controller => 'shows', :action => 'stillpost'
  map.connect 'shows/flag/:id', :controller => 'shows', :action => 'flag'
  map.connect 'faq', :controller => 'shows', :action => 'faq'
  map.connect 'shows/:id/add_show_description', :controller => 'shows', :action => 'add_show_description'
  map.connect 'sitemap.xml', :controller => "sitemap", :action => "sitemap" 
  map.connect ':city/:state', :controller => 'shows', :action => 'index'

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "locations", :action => 'route_to_location'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
