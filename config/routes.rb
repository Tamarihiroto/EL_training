Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tasks do
    get :search, on: :collection
    get :sort_by_order, on: :collection
  end
end
