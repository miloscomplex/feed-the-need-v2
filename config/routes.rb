Rails.application.routes.draw do

  root 'welcome#index'


  resources :needy, controller: 'needy/users'
  resources :donators, controller: 'donators/users'

  namespace :needy do
    resources :items
    get '/login', to: 'sessions#login', as: 'login'
    post '/login', to: 'sessions#create'
  end

  namespace :donators do
    resources :items
    get '/login', to: 'sessions#login', as: 'login'
    post '/login', to: 'sessions#create'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
