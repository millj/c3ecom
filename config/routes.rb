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
  resources :fct_startrack_connote_manual
  resources :fct_axima_controls
  resources :fct_vendor_axima_leadtimes

  resources :allocation_order_lines do
      collection do
        get :complete_gift_card
      end
  end
  resources :allocation_orders, only: [:index, :show, :edit, :update]

  resources :items, only: [:index, :show]

  resources :mb_order_statuses, only: [:index, :show]


  match '/signin',    to: 'sessions#new',          via: 'get'
  match '/signout',   to: 'sessions#destroy',      via: 'delete'

  match '/order_selection', :action => 'selection', :via => [:get], :controller => 'allocation_orders'

  get 'signup'   => 'users#new'
  get 'help'     => 'static_pages#help'
  get 'about'    => 'static_pages#about'
  get 'contact'  => 'static_pages#contact'


  post 'truncate' => 'static_pages#table_truncate'
  get  'truncate' => 'static_pages#truncate'

  post 'load'  => 'static_pages#load_table'
  get  'load'  => 'static_pages#load'

  post 'load_finance' => 'static_pages#load_table_finance'
  get  'load_finance' => 'static_pages#load_finance'

  post 'truncate_finance' => 'static_pages#truncate_table_finance'
  get  'truncate_finance' => 'static_pages#truncate_finance'

  post 'truncate_mecca' => 'static_pages#table_truncate_mecca'
  get  'truncate_mecca' => 'static_pages#truncate_mecca'

  post 'load_mecca'  => 'static_pages#load_table_mecca'
  get  'load_mecca'  => 'static_pages#load_mecca'

  post 'live_load_mecca'  => 'static_pages#live_table_mecca'
  get  'live_load_mecca'  => 'static_pages#live_mecca'

  post 'load_secret_shopper' => 'static_pages#load_secret_shopper'
  get  'load_secret_shopper' => 'static_pages#load_shopper'

  post 'truncate_km' => 'static_pages#table_truncate_km'
  get  'truncate_km' => 'static_pages#truncate_km'

  post 'load_km'  => 'static_pages#load_table_km'
  get  'load_km'  => 'static_pages#load_km'

  post 'live_load_km'  => 'static_pages#live_table_km'
  get  'live_load_km'  => 'static_pages#live_km'

  post 'select_oms_orders' => 'static_pages#select_oms_orders'
  get  'select_oms_orders' => 'static_pages#select_oms'

  post 'select_oms_orders2' => 'static_pages#select_oms_orders'
  get  'select_oms_orders2' => 'static_pages#select_oms2'

  post 'select_bulk_pick' => 'static_pages#select_bulk_pick'
  get  'select_bulk_pick' => 'static_pages#select_bulk'

  post 'print_gift_message' => 'static_pages#print_gift_message'
  get 'print_gift_message' => 'static_pages#print_gift'

  post 'print_gift_message2' => 'static_pages#print_gift_message2'
  get 'print_gift_message2' => 'static_pages#print_gift2'

  post 'reprint_gift_message' => 'static_pages#reprint_gift_message'
  get 'reprint_gift_message' => 'static_pages#reprint_gift'

  post 'dispatch_the_parcel' => 'static_pages#dispatch_the_parcel'
  get 'dispatch_the_parcel'  => 'static_pages#dispatch_the'

  post 'ship_the_parcel' => 'static_pages#ship_the_parcel'
  get 'ship_the_parcel'  => 'static_pages#ship_the'

  post 'unlock_the_order'  => 'static_pages#unlock_the_order'
  get 'unlock_the_order'  => 'static_pages#unlock_order'

  post 'unlock_the_order_a1w'  => 'static_pages#unlock_the_order_a1w'
  get 'unlock_the_order_a1w'  => 'static_pages#unlock_order_a1w'

  post 'reload_the_order_a1w'  => 'static_pages#reload_the_order_a1w'
  get 'reload_the_order_a1w'  => 'static_pages#reload_order_a1w'

  post 'cancel_purchase_order'  => 'static_pages#cancel_the_purchase_order'
  get 'cancel_purchase_order'  => 'static_pages#cancel_purchase'

  post 'archive_the_orders' => 'static_pages#archive_the_orders'
  get  'archive_orders' => 'static_pages#archive_orders'

  post 'order_count'  => 'static_pages#order_count_display'
  get  'order_count' => 'static_pages#order_count'

  get 'fct_axima_controls/place_on_hold'
  get 'fct_axima_controls/remove_from_hold'

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
