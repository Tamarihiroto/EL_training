Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tasks do
    get :search, on: :collection
    get :sort_by_order, on: :collection
  end

  resources :users
  get '/admin', to: 'users#index', as: 'admin_users'
  get '/admin/:id', to: 'users#show', as: 'admin_user'
  get '/admin/:id/edit', to: 'users#edit', as: 'edit_admin_user'
end
