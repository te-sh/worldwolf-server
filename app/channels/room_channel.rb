class RoomChannel < ApplicationCable::Channel
  def subscribed
    user = User.find(params[:user_id])
    stream_from "room-#{user.room.id}"
  rescue ActiveRecord::RecordNotFound
    reject
  end

  def unsubscribed; end

  def chat(data)
    user = User.find(params[:user_id])
    user.room.broadcast_chat(user, data['text'])
  end
end
