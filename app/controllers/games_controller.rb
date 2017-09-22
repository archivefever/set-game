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
          format.json do
            cardPartial = render partial: '/partials/card_show_next_deal', locals:{ player_selection: current_game.duct_tape }
            scorePartial = render partial: '/partials/current_game_stats', locals:{ game: current_game }

            render json: {
            new_cards_partial: cardPartial,
            score: scorePartial }.to_json
          end
       end
    else

    cardPartial = render_to_string partial: '/partials/card_show_next_deal', locals:{ player_selection: player_selection }
    scorePartial = render_to_string partial: '/partials/current_game_stats', locals:{ game: current_game }
      respond_to do |format|
        format.json do
            render json: {
            new_cards_partial: cardPartial,
            score: scorePartial }.to_json
          end
       end
    end

  end

end
