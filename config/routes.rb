Psp::Application.routes.draw do


  root to: 'states#index'
  #match "/states/:code" => "states#show"
  #match "/states", to: 'states#index'

  resources :leaders

  resources :states do
    resources :leaders
    resource :calendar
    resources :subscriptions
  end

  match "/states/:id/:year/:month/:day/calendars/daily/twitter", to: "states#twitter", as: "daily_twitter_feed"
  match "/states/:id/:year/:month/:day/calendars/daily/facebook", to: "states#facebook", as: "daily_facebook_feed"
  match "/states/:id/:year/:month/:day/calendars/daily/email", to: "states#email", as: "daily_email"
  match "/states/:id/email", to: "states#email", as: "state_email"

  match "/states/:id/calendars/daily/twitter", to: "states#twitter", as: "daily_twitter_feed"
  match "/states/:id/calendars/daily/facebook", to: "states#facebook", as: "daily_facebook_feed"

  match "/states/:id/calendars/daily/email", to: "states#email", as: "daily_email"
  #match "/states/:id/calendars/weekly/email", to: "states#weekly_email_feed", as: "weekly_email_feed"
  match "/states/:id/calendars/daily/:year/:month/:day", to: "states#show", as: "daily_calendar"
  match "/states/:id/calendars/weekly/:year/:month/:day", to: "states#show", as: "weekly_calendar"

  match "/states/:id/:year/:month/:day", to: "states#show", as: "state_date"

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

  # This line mounts Refinery's routes at the root of your application.
  # This means, any requests to the root URL of your application will go to Refinery::PagesController#home.
  # If you would like to change where this extension is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Refinery relies on it being the default of "refinery"
  #mount Refinery::Core::Engine, :at => '/'

end
