class SessionsController < ApplicationController

  def player
  end

  def destroy
    session[:player_id] = nil
    redirect_to '/'
  end

  def inspector
    render plain: session[:player_id].inspect
  end

  def create
    @player = Player.find_by(email: params[:session][:email])

    if @player && @player.authenticate(params[:session][:password])
      session[:player_id] = @player.id
      redirect_to "/"
    else
      redirect_to "/login", notice: "login info not right"
    end
  end


  private
  def session_params
    params.require(:session).permit(:username, :email, :password)
  end

end
