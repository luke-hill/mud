class ChangeRoomColumnNames < ActiveRecord::Migration[5.1]
  def change
    rename_column :rooms, :room_type, :room_type_id
    rename_column :rooms, :location, :location_id
    rename_column :rooms, :default_enemy, :enemy_id
  end
end
