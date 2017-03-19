Rails.application.routes.draw do
  root 'products#marketplace'

  get 'marketplace' => 'products#marketplace'
  get 'products/:slug' => 'products#show', as: :product
end
