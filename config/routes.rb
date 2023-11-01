Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/admins", to: "admins#index"
  get "/admins/merchants", to: "admin_merchants#index"
  get "/admins/invoices", to: "admin_invoices#index"
end
