class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string     :name
      t.references :room, type: :uuid
      t.boolean    :active, default: false

      t.timestamps
    end
  end
end
