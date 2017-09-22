class GamesController < ApplicationController

  def index
  end

  def new
    @game = Game.create
    @game.load_deck
    if current_user
      @game.update_attributes(player_id: current_user.id)
    end
    redirect_to game_path(@game)
  end

  def show
    @game = Game.last
  end

  def stats
    @game = Game.find(params[:id])
  end

  def check_cards
    player_selection = SetMatcher.find_cards(params[:selectedCardIds])
    if SetMatcher.is_a_set?(player_selection)
      SetMatcher.make_group(player_selection)
       respond_to do |format|
        format.html { render partial: '/partials/card_show_next_deal', locals:{player_selection: current_game.duct_tape}}
       end
    else
      respond_to do |format|
        format.html { render partial: '/partials/card_show_next_deal', locals:{player_selection: player_selection}}
       end

    end
  end

end
