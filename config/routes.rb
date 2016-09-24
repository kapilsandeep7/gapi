Rails.application.routes.draw do
  get 'reports/index'


   get "calender_events/(:id)" => "calender_events#index", :as => :calender_events
   get "fetch_events/(:id)" => "calender_events#fetch_events", :as => :fetch_events
   
   get "fetch_messages/(:id)" => "email_messages#fetch_messages", :as => :fetch_messages
   get "email_messages/(:id)" => "email_messages#index", :as => :email_messages
  get 'mailboxes/index'

  get 'mailboxes/show'

  get 'mailboxes/create'

  get 'mailboxes/delete'

  get 'dashboard/index'
  
  get "/auth/google_oauth2/callback" => "users#store"
  get "/auth/failure" => "users#failure"
  delete '/logout', to: 'users#destroy'
  
  #user crud
 
 
  get "/user/show" => "users#show"
  match "/edit/user/:id" => "users#edit_user",:via => [:post,:get, :patch] , :as => :edit_user
  match "/delete/user/:id" => "users#delete_user",:via => [:delete] , :as => :delete_user
  match '/add/user', :to=>'users#add_user',:via => [:post,:get] , :as => :add_user
  
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'users#index'
   

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
