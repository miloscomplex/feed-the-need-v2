Rails.application.routes.draw do

  root 'welcome#index'

  get '/login', to: 'sessions/sessions#login', as: 'login'
  post '/login', to: 'sessions/sessions#create'

  namespace :needies, path: 'needy' do
    resources :items
  end

  namespace :donators do
    resources :items, except: [:new, :create, :destroy]
  end

  resources :needies, controller: 'needies/users', path: 'needy'
  resources :donators, controller: 'donators/users', path: 'needy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
