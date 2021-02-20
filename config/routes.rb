require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, -> (user) { user.has_role?(:admin) } do
    mount PgHero::Engine, at: "pghero"
    mount Sidekiq::Web, at: "sidekiq"
  end

  devise_for :users, controllers: { registrations: "registrations" }

  get 'discourse/sso' => 'discourse_sso#sso'

  authenticate :user, -> (user) { user.has_role?(:admin) } do
    namespace :admin do
      resources :invites
      resources :articles
      resources :polls do
        resources :poll_answers
      end
      resources :clubs

      root to: 'invites#index'
    end
  end


  #TODO: Break out into users_controller and profile_controller?
  get '/golfare', to: 'users#index', as: :users
  get '/golfare/:id', to: 'profile#show', as: :user
  get '/profil', to: 'profile#index', as: :profile
  get '/profil/vanner/', to: 'profile#friends', as: :friends
  get '/profil/golfsnack/', to: 'profile#blog', as: :blog

  get '/profil/bild', to: 'profile#avatar', as: :profile_avatar
  get '/profil/omslagsbild', to: 'profile#coverimage', as: :profile_cover
  put '/profil/bild', to: 'profile#update_avatar', as: :update_avatar
  put '/profil/omslagsbild', to: 'profile#update_cover', as: :update_cover
  delete '/profil/bild', to: 'profile#delete_avatar', as: :delete_avatar
  delete '/profil/omslagsbild', to: 'profile#delete_cover', as: :delete_cover

  resources :articles, only: [:index, :show], path: 'artiklar'
  resources :posts, except: [:index], path: 'golfsnack' do
    resources :images, only: [:destroy]
    delete '/mainimage', to: "images#mainimage", as: :destroy_mainimage
  end
  resources :comments, only: [:create, :destroy], path: 'kommentarer'
  resources :clubs, only: [:index, :show], path: 'golfklubbar' do
    collection { get 'search' }
    get '/bild', to: "clubs#logo", as: :logo
    get '/omslagsbild', to: "clubs#cover", as: :cover
    put '/bild', to: "clubs#update_logo", as: :update_logo
    put '/omslagsbild', to: "clubs#update_cover", as: :update_cover
    delete '/bild', to: "clubs#delete_logo", as: :delete_logo
    delete '/omslagsbild', to: "clubs#delete_cover", as: :delete_cover
  end

  post '/follow', to: 'follows#create', as: :follow
  post "/unfollow", to: 'follows#destroy', as: :unfollow
  post '/like', to: 'likes#create', as: :like
  post '/unlike', to: 'likes#destroy', as: :unlike

  post '/vote', to: 'polls#vote', as: :vote

  get '/ledartavla', to: 'leaderboard#index', as: :leaderboard
  get '/anvandaravtal', to: 'public#useragreement', as: :user_agreement
  get '/vanliga-fragor-och-svar', to: 'public#faq', as: :faq
  get '/om-golfsnack', to: 'public#about_us', as: :about_us

  root to: 'home#index'

  if Rails.env.development?
    get '/styleguide', to: 'styleguide#index'
  end
end
