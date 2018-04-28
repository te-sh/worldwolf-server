class CreateGameWolves < ActiveRecord::Migration[5.2]
  def change
    create_table :game_wolves, id: :uuid do |t|
      t.references :game, type: :uuid
      t.references :wolf, type: :uuid

      t.timestamps
    end
  end
end
