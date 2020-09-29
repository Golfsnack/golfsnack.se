Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  get '/admin', to: 'admin#index'
  post '/admin', to: 'admin#create', as: :create_invitation

  # -----

  get '/guider', to: 'guides#index'
  get '/guider/:slug', to: 'guides#show'

  get '/profil', to: 'profile#index', as: :profile

  root to: 'home#index'
end
