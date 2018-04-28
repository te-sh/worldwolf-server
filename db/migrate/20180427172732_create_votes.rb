class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes, id: :uuid do |t|
      t.references :game, type: :uuid
      t.references :voter, type: :uuid
      t.references :votee, type: :uuid

      t.timestamps
    end
  end
end
