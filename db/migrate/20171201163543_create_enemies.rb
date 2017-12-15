class CreateEnemies < ActiveRecord::Migration[5.1]
  def change
    create_table :enemies do |t|
      t.string :name
      t.string :description
      t.integer :weapon_id
      t.integer :armor_id
      t.integer :lower_hp_limit
      t.integer :upper_hp_limit
      t.float :accuracy
      t.integer :lower_gold_limit
      t.integer :upper_gold_limit
      t.integer :xp
      t.integer :xp_killshot
      t.integer :stamina

      t.timestamps
    end
  end
end
