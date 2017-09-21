Rails.application.routes.draw do

    resources :sessions, only: [:new, :destroy, :create]
    resources :players, only: [:new, :show, :create]
    resources :games, only: [:index, :new, :show, :create]

    post '/games/check_cards' => 'games#check_cards'
    get '/session-inspector' => 'sessions#inspector'
    get '/logout' => 'sessions#destroy'
    get '/login' => 'sessions#new'

    root 'games#index'
end
