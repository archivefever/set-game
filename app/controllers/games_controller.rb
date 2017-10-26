class GamesController < ApplicationController

  def index
  end

  def new
    @game = Game.create
    @game.load_deck
    session[:game_id] = @game.id
    if current_user
      @game.update_attributes(player_id: current_user.id)
    end
    redirect_to game_path(@game)
  end

  def show
    @game = current_game
  end

  def stats
    @game = current_game
  end

  def check_remaining_cards
    if request.xhr?
      render json: current_game.undrawn_cards.count
    end
  end

  # DI, Oct 26: We are checking cards on the front end, so we don't need this anymore.
  # The make_group and duct_tape functionality will have to be called elsewhere.
  # def check_cards
  #   p params[:selectedCardIds]
  #   player_selection = SetMatcher.find_cards(params[:selectedCardIds])
  #   if SetMatcher.is_a_set?(player_selection)
  #     SetMatcher.make_group(player_selection, current_game.id)
  #      respond_to do |format|
  #       format.html { render partial: '/partials/card_show_next_deal', locals:{player_selection: current_game.duct_tape}}
  #      end
    # else
    #   respond_to do |format|
    #     format.html { render partial: '/partials/card_show_next_deal', locals:{player_selection: player_selection}}
    #    end
  #   end
  # end

  def update_game_state
    p "UPDATE GAME STATE"
    p params[:selectedCardIds]
    player_selection = SetMatcher.find_cards(params[:selectedCardIds])
    SetMatcher.make_group(player_selection, current_game.id)
    SetMatcher.make_group(player_selection, current_game.id)
    respond_to do |format|
      format.html { render partial: '/partials/card_show_next_deal', locals:{player_selection: current_game.duct_tape}}
    end
  end

  def set_count
    if request.xhr?
      render json: current_game.sets_made
    end
  end

end
