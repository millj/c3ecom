C3ecom::Application.routes.draw do

  #get "baskets/update"
  #get "baskets/index"
  root 'static_pages#home'

  resources :users
  resources :baskets
  resources :sessions, only: [:new, :create, :destroy]
  resources :direct_bin_contents
  resources :fct_store_pick_scans
  resources :pick_paths
  resources :allocation_order_lines, only: [:index, :show]
  resources :allocation_orders, only: [:index, :show]
  resources :items, only: [:index, :show]

  match '/signin',    to: 'sessions#new',          via: 'get'
  match '/signout',   to: 'sessions#destroy',      via: 'delete'

  get 'signup'   => 'users#new'
  get 'help'     => 'static_pages#help'
  get 'about'    => 'static_pages#about'
  get 'contact'  => 'static_pages#contact'

  post 'truncate' => 'static_pages#table_truncate'
  get  'truncate' => 'static_pages#truncate'

  post 'load'  => 'static_pages#load_table'
  get  'load'  => 'static_pages#load'


  get 'allocate' => 'allocation_order_lines#allocate'
  post 'allocate' => 'allocation_order_lines#allocate_item'

  get 'giftcard'  => 'allocation_order_lines#giftcard'
  post 'giftcard' => 'allocation_order_lines#giftcard'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
