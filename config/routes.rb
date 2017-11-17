Rails.application.routes.draw do


    mount ActionCable.server => '/cable'

    # post '/games/check_cards' => 'games#check_cards'
    get 'games/stats' => 'games#stats'
    post 'games/update_game_state' => 'games#update_game_state'
    post 'games/check_remaining_cards' => 'games#check_remaining_cards'
    post 'games/set_count' => 'games#set_count'

    resources :games, only: [:index, :new, :show, :create]

    devise_for :players, controllers: {
    sessions: 'players/sessions'
    }

    get 'waiting_room' => 'games#waiting_room', as: 'waiting_room'

    # get '/' => 'games#index'
    root 'games#index'
end

