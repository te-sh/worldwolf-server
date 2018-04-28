class GameWolf < ApplicationRecord
  belongs_to :game
  belongs_to :wolf, class_name: 'User'
end
