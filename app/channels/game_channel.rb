class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "player_#{uuid}"
    Seek.create(uuid)
  end

  def make_move(data)
    Game.make_move(uuid, data)
  end

  def unsubscribed
    Seek.remove(uuid)
    Game.forfeit(uuid)
  end
end
