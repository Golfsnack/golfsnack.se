Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  get 'discourse/sso' => 'discourse_sso#sso'

  namespace :admin do
    root to: 'base#index'
    post '/', to: 'base#create', as: :create_invitation

    resources :articles
  end


  get '/profil', to: 'profile#index', as: :profile
  get '/users/:id', to: 'profile#show', as: :user
  get '/profil/vanner/', to: 'profile#friends', as: :friends
  get '/profil/blogg/', to: 'profile#blog', as: :blog

  resources :articles, only: [:index, :show], path: 'artiklar'
  resources :posts, path: 'bloggar'
  resources :comments, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]

  post '/like', to: 'likes#create', as: :like
  post '/unlike', to: 'likes#destroy', as: :unlike

  get '/ledartavla', to: 'leaderboard#index', as: :leaderboard

  root to: 'home#index'
end
