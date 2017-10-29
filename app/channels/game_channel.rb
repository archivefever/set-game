class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def check_sets(json)
    card_ids = json['card_ids']
    game_id = json['game_id'].to_i
    current_game = Game.find(game_id)
    player_selection = SetMatcher.find_cards(card_ids)
    SetMatcher.make_group(card_ids, current_game)
  end

  def select_card(json)
    card_id = json['card']
    ActionCable.server.broadcast "game_channel", {action: "select_card", card: card_id }
  end

  def initial_deal(json)
    p json
    game_id = json['game_id'].to_i
    this_game = Game.find(game_id)
    this_game.initial_deal

  end

end
