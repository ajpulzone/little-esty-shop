Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # feel free to remove or change or delete this resource; ask MM if you have any questions about it
  
  resources :merchants, only: [:index]
  
  resources :merchants do
    resources :invoices, only: [:index, :show]
    resources :items, only: [:index, :show, :edit, :update]  
  end

  namespace :admin do
    resources :dashboard, only: [:index, :show]
    resources :invoices, only: [:index, :show]
    resources :merchants, only: [:index, :show]
  end
end
