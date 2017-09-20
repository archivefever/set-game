class GamesController < ApplicationController

  def new

  end

  def show

  end

  def create
    if current_user
      @game = Game.create(player_id: current_user.id)
    else
      @game = Game.create
    end
    redirect_to game_url
  end

end
