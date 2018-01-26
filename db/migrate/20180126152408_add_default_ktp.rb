class AddDefaultKtp < ActiveRecord::Migration[5.1]
  def change
    change_column :rooms, :ktp, :boolean, default: false
  end
end
