Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # feel free to remove or change or delete this resource; ask MM if you have any questions about it

  resources :merchants, only: [:index]
  
  get 'merchants/:id/dashboard', to: 'merchants#show'

  resources :merchants do
    resources :invoices, only: %i[index show]
    resources :items, only: %i[index show new create edit update]
    resources :invoice_items, only: [:update]
  end

  namespace :admin do
    resources :dashboard, only: [:index, :show]
    resources :invoices, only: [:index, :show, :update]
    resources :merchants, only: [:index, :show, :update]
  end
end
