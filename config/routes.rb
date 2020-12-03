Rails.application.routes.draw do

  root 'welcome#index'

  namespace :needy do
    get '/login', to: 'sessions#login', as: 'login'
    post '/login', to: 'sessions#create'
    resources :items
  end

  namespace :donators do
    resources :items, :except [:new, :create, :destroy]
    get '/login', to: 'sessions#login', as: 'login'
    post '/login', to: 'sessions#create'
  end

  resources :needy, controller: 'needy/users'
  resources :donators, controller: 'donators/users'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
