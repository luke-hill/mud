class AddEnemyPresentToRooms < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :enemy_hp, :integer, default: 0
  end
end
