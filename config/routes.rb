Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  resources :merchants do
    get 'dashboard', on: :member
  end
  
  namespace :admin do
    resources :merchants
    resources :invoices, only: [:index, :show]
    get "", to: "dashboard#index", as: "dashboard"
  end
end
