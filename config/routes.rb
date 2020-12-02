Rails.application.routes.draw do

  resources :needy, controller: 'needy/needy'
  resources :donators, controller: 'donators/donators'

  namespace :needy do
    resources :items
  end

  namespace :donators do
    resources :items
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
