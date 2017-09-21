class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= Player.find_by(id: session[:player_id]) if session[:player_id]
  end
  helper_method :current_user

  def current_game
    @current_game ||= Game.last
  end
  helper_method :current_game

end
