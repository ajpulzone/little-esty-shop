Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # feel free to remove or change or delete this resource; ask MM if you have any questions about it

  resources :merchants, only: [:index]
  
  get 'merchants/:id/dashboard', to: 'merchants#show'

  resources :merchants do
    resources :invoices, only: %i[index show]

    resources :items, only: %i[index show new create edit update]
  end

  # get "/admin", to: "admin#index"
  resources :admin, only: [:index]

  # namespace :admin do
  #     resources :merchants, only: [:index]
  #     resources :invoices, only: [:index]
  # end
end
