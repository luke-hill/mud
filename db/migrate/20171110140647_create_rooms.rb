class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.integer :room_id
      t.integer :north
      t.integer :south
      t.integer :east
      t.integer :west
      t.integer :up
      t.integer :down

      t.boolean :hide_north
      t.boolean :hide_south
      t.boolean :hide_east
      t.boolean :hide_west
      t.boolean :hide_up
      t.boolean :hide_down

      t.integer :north_key
      t.integer :south_key
      t.integer :east_key
      t.integer :west_key
      t.integer :up_key
      t.integer :down_key

      t.integer :room_type
      t.integer :location
      t.boolean :guards
      t.boolean :ktp
      t.integer :default_enemy

      t.string :description
      t.string :advanced_description

      t.timestamps
    end
  end
end
