Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  get 'discourse/sso' => 'discourse_sso#sso'

  namespace :admin do
    root to: 'base#index'
    post '/', to: 'base#create', as: :create_invitation

    resources :articles
    resources :polls do
      resources :poll_answers
    end
  end


  #TODO: Break out into users_controller and profile_controller?
  get '/golfare', to: 'users#index', as: :users
  get '/golfare/:id', to: 'profile#show', as: :user
  get '/profil', to: 'profile#index', as: :profile
  get '/profil/vanner/', to: 'profile#friends', as: :friends
  get '/profil/golfsnack/', to: 'profile#blog', as: :blog

  resources :articles, only: [:index, :show], path: 'artiklar'
  resources :posts, except: [:index], path: 'golfsnack' #TODO: Remove!
  resources :comments, only: [:create, :destroy], path: 'kommentarer'
  resources :clubs, only: [:index, :show], path: 'golfklubbar'

  resources :registration_steps

  post '/follow', to: 'follows#create', as: :follow
  post "/unfollow", to: 'follows#destroy', as: :unfollow
  post '/like', to: 'likes#create', as: :like
  post '/unlike', to: 'likes#destroy', as: :unlike

  post '/vote', to: 'polls#vote', as: :vote

  get '/ledartavla', to: 'leaderboard#index', as: :leaderboard

  root to: 'home#index'

  if Rails.env.development?
    get '/styleguide', to: 'styleguide#index'
  end
end
