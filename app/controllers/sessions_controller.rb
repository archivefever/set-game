class SessionsController < ApplicationController

  def new
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

  def inspector
    render plain: session[:user_id].inspect
  end

  def create
    @player = Player.find_by(username: params[:session][:username])

    if @player.authenticate(params[:session][:password])
      session[:user_id] = @player.id
      redirect_to "/"
    else
      @errors = ['login info not right']
      render :new
    end
  end


  private
  def session_params
    params.require(:session).permit(:username, :email, :password)
  end

end
