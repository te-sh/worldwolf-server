class UserChannel < ApplicationCable::Channel
  def subscribed
    user = User.find(params[:user_id])
    stream_from "user-#{user.id}"
  end

  def unsubscribed; end
end
