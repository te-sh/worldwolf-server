module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :user_id

    def connect
      user = find_verified_user
      if user
        self.user_id = user.id
      else
        reject_unauthorized_connection
      end
    end

    def find_verified_user
      user_id = request.params[:user_id]
      return unless user_id
      User.find(user_id)
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end
end
