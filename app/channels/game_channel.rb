class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "player_#{uuid}"
  end

  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
