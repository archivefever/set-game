Rails.application.routes.draw do


    mount ActionCable.server => '/cable'

    # post '/games/check_cards' => 'games#check_cards'
    get 'games/stats' => 'games#stats'
    post '/games/update_game_state' => 'games#update_game_state'
    post '/games/check_remaining_cards' => 'games#check_remaining_cards'
    post '/games/set_count' => 'games#set_count'

    get '/waiting-room' => 'games#waiting', as: 'waiting'

    root 'games#index'
end

