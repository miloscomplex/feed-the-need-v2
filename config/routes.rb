Rails.application.routes.draw do

  root 'welcome#index'

  get '/login', to: 'sessions/sessions#login', as: 'login'
  post '/login', to: 'sessions/sessions#create'

  resources :needies, controller: 'needies/users', path: 'needy' do
    resources :items, controller: 'needies/items'
  end

  resources :donators, except: [:index], controller: 'donators/users' do
    resources :items, except: [:new, :create, :destroy], controller: 'donators/items'
  end

  #resources :needies, controller: 'needies/users', path: 'needy'
  #resources :donators, except: [:index], controller: 'donators/users'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
