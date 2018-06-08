class Room < ApplicationRecord
  include RoomCable

  has_many :users, -> { order(created_at: :asc) }
  has_one :game

  validates :pass, presence: true, length: { maximum: 10 }, on: :update

  JSON_LIST = { only: %i[id name], methods: :users_count }
  JSON_DETAIL = {
    only: %i[id name], include: {
      users: { only: %i[id name active] },
      game: { only: %i[id creator_id updated_at], methods: :playing }
    }
  }

  def users_count
    users.count
  end

  def check_or_update_pass(pass)
    if users.count.zero?
      update!(pass: pass)
    else
      self.pass == pass
    end
  end
end
