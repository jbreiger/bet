Rails.application.routes.draw do

  get 'bets' => "bets#index"
  get 'bets/create' => "bets#create"
  get "bets/check" => "bets#check"
  get "bets/:id" => "bets#show"

  get 'practice/:id' => 'practices#index'
  post 'practice/:id' => 'practices#bet'
  get 'practice/match/:id' => 'practices#match'
  get 'practice/team/:id' => 'practices#show'

  get 'teams' => "teams#index"
  post 'teams' => "teams#create"
  get 'teams/table' => "teams#table"
  get 'teams/betable' => "teams#betable"
  get "teams/schedule" => "teams#schedule"
  # get "teams/new_schedule" => "teams#new_schedule"

  get 'teams/:id' => "teams#show"

  get 'favorite_create/:id' => "teams#favorite_create"
  get 'favorite' => "teams#favorite"
  delete 'favorite/:id' => "teams#favorite_delete"

  get 'match/:id' => 'comments#match'
  

  post "user_bets/:id" => "user_bets#create"
  get "user_bet/cashout/:id" => "user_bets#cashout"

  
  root 'users#new'
  get 'users/new' => 'users#new'
  post 'users/create' => 'users#create'
  post 'sessions' => 'sessions#create'
  get 'users/edit' => 'users#edit'
  patch 'users' => 'users#update'
  get 'users' => 'users#index'

  post 'comment/create/:id' => 'comments#create'

  post 'matchcomment/create/:id' => 'comments#matchcommentcreate'

  get 'sessions/logout' => 'sessions#destroy'

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
