class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  # def current_user
  #   @current_user ||= Player.find_by(id: session[:player_id]) if session[:player_id]
  # end
  # helper_method :current_user

  def current_game
    @current_game ||= Game.find(session[:game_id]) if session[:game_id]
  end
  helper_method :current_game

  protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password])
        # devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :current_password])
    end

end
