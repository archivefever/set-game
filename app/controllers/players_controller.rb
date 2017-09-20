class PlayersController < ApplicationController

  def new
    @user = Player.new
  end

  def show
    set_player
    if current_user && current_user.id == @player.id
      render :show
    else
      redirect_to '/'
    end
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      session[:player_id] = @player.id
      redirect_to "/players/#{@player.id}"
    else
      redirect_to "/players/new", notice: "registration info invalid"
    end
  end

  private

  def set_player
    @player = Player.find_by(id: params[:id])
  end

  def player_params
    params.require(:player).permit(:username, :email, :password, :password_confirmation)
  end

end
