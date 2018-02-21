module ApplicationCable
  class Connection < ActionCable::Connection::Base

    identified_by :current_user

    def connect
      p "@@@@@@@@@@@@"
      # p cookies[:user_id]
      # p cookies[:player_id]
      p env['warden'].user
      # p env['warden'].player
      p "@@@@@@@@@@@@"
      self.current_user = Player.find_by(id: cookies[:player_id])
    end

    # private
    #   def find_verified_user
    #     if verified_user = Player.find_by(id: cookies.encrypted[:user_id])
    #       verified_user
    #     else
    #       reject_unauthorized_connection
    #     end
    #   end
  end
end
