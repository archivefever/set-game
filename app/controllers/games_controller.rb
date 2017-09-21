class GamesController < ApplicationController

  def index
  end

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


  def check_cards
    player_selection = SetMatcher.find_cards(params[:selectedCardIds])
    if SetMatcher.is_a_set?(player_selection)
      current_game.next_deal
    else
      params[:selectedCardIds]
    end

  end

end
