class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak
    ActionCable.server.broadcast "room_channel", message: "Cheat is activated."
  end

  def check_cards(data)
    # game = GameHelper.get_current_game
    # p game
    card_ids = data["card_data"]
    game_id = data["game_id"]
    p card_ids
    game = Game.find(game_id)
    player_selection = SetMatcher.find_cards(card_ids)
      SetMatcher.make_group(player_selection, game_id)

      # ActionCable.server.broadcast "room_channel", {action: "next_deal", next_deal: render_next_deal, sets_made: game.sets_made}
  end

end

