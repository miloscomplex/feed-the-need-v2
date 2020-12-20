Rails.application.routes.draw do

  root 'welcome#index'

  get '/login', to: 'sessions/sessions#login', as: 'login'
  post '/login', to: 'sessions/sessions#create'

  get '/logout', to: 'sessions/sessions#logout', as: 'logout'

  resources :needies, controller: 'needies/users', path: 'needy' do
    resource :items, controller: 'needies/items'
  end

  resources :donators, controller: 'donators/users' do
    post '/donate_items', to: 'donators/needies#donate_items', as: 'donate_items'
    resources :needies, controller: 'donators/needies', only: [:index, :show], path: 'needy' do
      resource :items, except: [:new, :create, :destroy], controller: 'donators/items'
    end
    # define custom routes since it should be displayed and edited as a set?
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
