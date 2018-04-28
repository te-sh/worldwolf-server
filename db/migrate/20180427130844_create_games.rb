class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games, id: :uuid do |t|
      t.references :room, type: :uuid
      t.references :creator, type: :uuid
      t.string     :normal_word
      t.string     :wolf_word

      t.timestamps
    end
  end
end
