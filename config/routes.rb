Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  get 'discourse/sso' => 'discourse_sso#sso'

  namespace :admin do
    root to: 'base#index'
    post '/', to: 'base#create', as: :create_invitation

    resources :guides
  end


  get '/profil', to: 'profile#index', as: :profile
  get '/users/:id', to: 'profile#show', as: :user
  get '/profil/vanner/', to: 'profile#friends', as: :friends
  get '/profil/blogg/', to: 'profile#blog', as: :blog

  resources :guides, only: [:index, :show], path: 'guider'
  resources :posts, path: 'bloggar'
  resources :friendships, only: [:create, :destroy]

  get '/ledartavla', to: 'leaderboard#index', as: :leaderboard

  root to: 'home#index'
end
