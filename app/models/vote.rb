class Vote < ApplicationRecord
  after_create_commit :created
  after_update_commit :created

  belongs_to :game
  belongs_to :voter, class_name: 'User'
  belongs_to :votee, class_name: 'User'

  validates :game, presence: true
  validates :voter, presence: true
  validates :votee, presence: true

  JSON = {
    include: {
      voter: { only: %i[id name] },
      votee: { only: %i[id name] }
    }
  }

  def created
    game.creator.broadcast_votes(game.votes)
  end
end
