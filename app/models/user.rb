class User < ApplicationRecord
  include UserCable

  after_create_commit :created
  after_update_commit :updated
  after_destroy_commit :destroyed

  belongs_to :room

  validates :name, presence: true, length: { maximum: 8 }

  JSON = { only: %i[id name] }

  class << self
    def create_with_pass(room_id, name, pass)
      transaction do
        room = Room.find(room_id)
        return unless room.check_or_update_pass(pass)

        user = User.new(name: name)
        room.users << user
        user.save!
        user
      end
    rescue ActiveRecord::RecordInvalid
      nil
    end
  end

  def created
    room.broadcast_enter(self)
  end

  def updated
    room.broadcast
  end

  def destroyed
    room.broadcast_leave(self)
  end
end
