Rails.application.routes.draw do

    resources :sessions, only: [:new, :destroy, :create]
    resources :players, only: [:new, :show, :create]
    resources :games, only: [:new, :show, :create]

    get '/session-inspector' => 'sessions#inspector'
    get '/logout' => 'sessions#destroy'
    get '/login' => 'sessions#new'

    root 'players#new'
end
