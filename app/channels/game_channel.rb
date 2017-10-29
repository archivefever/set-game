class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def check_sets(json)
    p json
    p json['card_ids']
    p json['game_id']
    card_ids = json['card_ids']
    game_id = json['game_id']
    current_game = Game.find(game_id.to_i)
    player_selection = SetMatcher.find_cards(card_ids)
    SetMatcher.make_group(card_ids, current_game)
  end

end
