Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # feel free to remove or change or delete this resource; ask MM if you have any questions about it
  resources :merchants, only: [:index]
  
  get 'merchants/:id/dashboard', to: 'merchants#show'
  get 'merchants/:id/invoices', to: 'invoices#index'

  resources :merchants do
    resources :items, only: [:index, :show]
  end

end
