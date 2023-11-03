Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # resources :merchants do
  #   get "dashboard", on: :member
  #   # resources :invoices, only: [:index, :show]
  # end
  scope module: :merchants, path: "/" do
    resources :merchants, only: [:show] do
    resource :dashboard, only: [:show]
    resources :items
    resources :invoices, only: [:show, :index, :new, :create, :edit, :update, :destroy]
    end
  end

  namespace :admin do
    resources :merchants, only: [:index, :show]
    resources :invoices, only: [:index, :show]
    get "", to: "dashboard#index", as: "dashboard"
  end
end
