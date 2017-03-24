Rails.application.routes.draw do
  devise_for :clients, controllers: {
    sessions: 'clients/sessions',
    registrations: 'clients/registrations' 
  }
  root 'products#marketplace'

  get 'carts/show' => 'carts#show'
  get 'carts/checkout' => 'carts#checkout'
  get 'carts/add_product/:slug' => 'carts#add_product'

  get 'marketplace' => 'products#marketplace'
  get 'products/:slug' => 'products#show', as: :product
end
