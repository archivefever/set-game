class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "player_#{uuid}"
    stream_from "game_channel"
    Seek.create(uuid)
  end

  def unsubscribed
    Seek.remove(uuid)
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
    game_id = json['game_id'].to_i
    game = Game.find(game_id)
    game.initial_deal
  end

  def bad_set
    ActionCable.server.broadcast "game_channel", {action: "bad_set"}
  end

end
