class Game < ApplicationRecord
  after_create_commit :created
  after_update_commit :updated
  after_destroy_commit :destroyed

  belongs_to :room
  belongs_to :creator, class_name: 'User'
  has_many :game_wolves, dependent: :destroy
  has_many :wolves, through: :game_wolves
  has_many :votes, dependent: :destroy

  accepts_nested_attributes_for :game_wolves

  validates :room, presence: true
  validates :creator, presence: true
  validates :normal_word, presence: true, on: :update
  validates :wolf_word, presence: true, on: :update
  validates :game_wolves, presence: true, on: :update

  JSON = { only: %i[id creator] }
  JSON_DETAIL = {
    only: %i[id normal_word wolf_word],
    include: { wolves: { only: %i[id name] } }
  }

  def playing
    normal_word.present? && wolf_word.present?
  end

  def players
    room.users.select(&:active).reject { |user| creator == user }
  end

  def created
    room.broadcast_set_game(creator)
  end

  def updated
    room.broadcast_start_game(creator)
    distribute_word
  end

  def destroyed
    room.broadcast_finish_game(playing ? 'finish' : 'cancel')
  end

  def distribute_word
    normals = players - wolves
    normals.each { |player| player.broadcast_word(normal_word) }
    wolves.each { |player| player.broadcast_word(wolf_word) }
  end
end
