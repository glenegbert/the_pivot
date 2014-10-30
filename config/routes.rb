Rails.application.routes.draw do

  resources :items

	resources :orders

  resources :categories

  resources :addresses

  get 'code', to: 'home#code'

  get 'complete_delivery_order', to: 'orders#create'
  get 'checkout',         to: 'checkouts#show'
  get 'complete_order',   to: 'checkouts#complete_order'

  get 'cart',             to: 'carts#show',           as: 'cart'
  get 'add_item',         to: 'carts#add_item',       as: 'add_item'
  get 'remove_item',      to: 'carts#remove_item',    as: 'remove_item'
  put 'update_quantity',  to: 'carts#update_quantity',as: 'update_quantity'

  namespace :admin do
    resources :items, :categories, :orders, :order_items
    get 'dashboard',          to: 'dashboard#show'
  end

  get  'stores',     to: 'store_dashboard#index', as: 'store_dashboard'
  get  'store/:id',  to: 'store_dashboard#show', as: 'store_show'
  patch 'store/:id',  to: 'store_dashboard#update',  as: 'update_store'

  resources :users

  get ':id', to: 'stores#show', as: 'stores'

  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  root 'home#index'

  resources :home

  get 'confirmation', to: 'confirmations#show'


  get 'gift_cards', to: 'gift_cards#show'
  get 'about',      to: 'about#show'
  match '/contact_us',     to: 'contact_us#new',             via: 'get'
  resources "contact_us", only: [:new, :create]

end
