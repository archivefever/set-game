class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "player_#{current_user}"
    stream_from "game_channel"
    p current_user
    Seek.create(current_user)
  end

  def unsubscribed
    Seek.remove(current_user)
  end

  def group_set(json)
    card_ids = json['card_ids']
    game_id = json['game_id'].to_i
    player_id = json['player_id'].to_i

    player = Player.find(player_id)
    current_game = Game.find(game_id)
    player_selection = SetMatcher.find_cards(card_ids)
    SetMatcher.make_group(card_ids, current_game, player)
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
