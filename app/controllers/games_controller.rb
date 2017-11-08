class GamesController < ApplicationController

  def index

  end

  def new
    @game = Game.create
    @game.load_deck
    session[:game_id] = @game.id
    if current_user
      @game.players << current_user
    end
    redirect_to game_path(@game)
  end

  def show
    @game = current_game || @game = Game.find(params[:id])
    @player = current_user if current_user
  end

  def stats
    @game = current_game
  end

  def check_remaining_cards
    if request.xhr?
      render json: current_game.undrawn_cards.count
    end
  end


  def update_game_state
    player_selection = SetMatcher.find_cards(params[:selectedCardIds])
    SetMatcher.make_group(player_selection, current_game)
    respond_to do |format|
      format.html { render partial: '/partials/card_show_next_deal', locals:{player_selection: current_game.duct_tape}}
    end
  end

  def set_count
    if request.xhr?
      render json: current_game.sets_made
    end
  end

  def waiting

  end

end
