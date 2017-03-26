Rails.application.routes.draw do
  devise_for :clients, controllers: {
    sessions: 'clients/sessions',
    registrations: 'clients/registrations'
  }
  root 'products#marketplace'

  get 'carts/show' => 'carts#show'
  post 'carts/checkout' => 'carts#checkout'
  get 'carts/add_product/:slug' => 'carts#add_product', as: :add_to_cart
  get 'carts/remove_product/:id' => 'carts#remove_product', as: :remove_from_cart
  get 'carts/apply_cupon' => 'carts#apply_cupon'

  post 'webhooks/moip' => 'webhooks#moip'

  get 'marketplace' => 'products#marketplace'
  get 'products/:slug' => 'products#show', as: :product
end
