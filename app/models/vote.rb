class Vote < ApplicationRecord
  belongs_to :game
  belongs_to :voter, class_name: 'User'
  belongs_to :votee, class_name: 'User'

  validates :game, presence: true
  validates :voter, presence: true
  validates :votee, presence: true
end
