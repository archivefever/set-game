Rails.application.routes.draw do


    mount ActionCable.server => '/cable'

    # post '/games/check_cards' => 'games#check_cards'
    get 'games/stats' => 'games#stats'
    post '/games/update_game_state' => 'games#update_game_state'
    post '/games/check_remaining_cards' => 'games#check_remaining_cards'
    post '/games/set_count' => 'games#set_count'
    get '/session-inspector' => 'sessions#inspector'
    get '/logout' => 'sessions#destroy'
    get '/login' => 'sessions#new'

    resources :sessions, only: [:new, :destroy, :create]
    resources :players, only: [:new, :show, :create]
    resources :games, only: [:index, :new, :show, :create]

    root 'games#index'
end

