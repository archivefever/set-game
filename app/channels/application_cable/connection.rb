module ApplicationCable
  class Connection < ActionCable::Connection::Base

    identified_by :current_user

    def connect
      p "@@@@@@@@@@@@"
      p env['warden'].user
      p "@@@@@@@@@@@@"

      self.current_user = find_verified_user
    end

    protected

    def find_verified_user # this checks whether a user is authenticated with devise
      if verified_user = env['warden'].user
        verified_user
      else
        reject_unauthorized_connection
      end
    end

      # def find_verified_user
      #   if verified_user = Player.find_by(id: cookies.encrypted[:user_id])
      #     verified_user
      #   else
      #     reject_unauthorized_connection
      #   end
      # end
  end
end
