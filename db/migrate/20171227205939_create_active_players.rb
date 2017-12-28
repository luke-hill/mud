class CreateActivePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :active_players do |t|
      t.string :name
      t.integer :max_hp
      t.integer :hp
      t.integer :level
      t.integer :stamina
      t.integer :experience
      t.integer :gold
      t.integer :room_id
      t.integer :item_one
      t.integer :item_two
      t.integer :item_three
      t.integer :item_four
      t.integer :item_five
      t.integer :item_six

      t.timestamps
    end
  end
end
