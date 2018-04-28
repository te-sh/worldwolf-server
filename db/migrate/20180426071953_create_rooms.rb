class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms, id: :uuid do |t|
      t.string   :name
      t.integer  :order
      t.string   :pass
      t.datetime :last_access

      t.timestamps
    end
  end
end
