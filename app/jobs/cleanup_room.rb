class CleanupRoom
  include Sidekiq::Worker

  def perform
    Room.all.each do |room|
      next if room.users.count.zero? || expire?(room)

      room.broadcast_expire
      room.users.each do |user|
        cleanup_user(user)
      end
      cleanup_game(room)
    end
  end

  def expire?(room)
    Time.now < room.last_access + 15.minutes
  end

  def cleanup_user(user)
    conn = ActionCable.server.remote_connections.where(user_id: user.id)
    conn&.disconnect
    user.destroy
  end

  def cleanup_game(room)
    room.game&.destroy
  end
end
