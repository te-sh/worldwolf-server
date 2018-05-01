class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string     :name
      t.references :room, type: :uuid
      t.boolean    :active, default: false
      t.string     :token

      t.timestamps
    end
    add_index :users, :token, unique: true
  end
end
