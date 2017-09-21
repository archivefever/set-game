class GamesController < ApplicationController

  def index
  end

  def new

  end

  def show
    @game = Game.last
    p @game.id
    @game.load_deck
  end

  def create
    if current_user
      @game = Game.create(player_id: current_user.id)
    else
      @game = Game.create
    end
    redirect_to game_url
  end

  def stats
    @game = Game.last
  end

  def check_cards
    player_selection = SetMatcher.find_cards(params[:selectedCardIds])
    if !game_over?
      if SetMatcher.is_a_set?(player_selection)
        SetMatcher.make_group(player_selection)
         respond_to do |format|
          format.html { render partial: '/partials/card_show_three', locals:{player_selection: current_game.next_deal}}
         end
      else
        respond_to do |format|
          format.html { render partial: '/partials/card_show_three', locals:{player_selection: player_selection}}
         end
      end
    else
      game = Game.last
      redirect_to "/games/#{game.id}/stats"
    end
  end

end
