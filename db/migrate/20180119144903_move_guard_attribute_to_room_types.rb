class MoveGuardAttributeToRoomTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :room_types, :guards, :boolean, default: true
    remove_column :rooms, :guards
  end
end
