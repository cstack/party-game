class AddColorToRoomUsers < ActiveRecord::Migration[6.1]
  def change
  	add_column :room_users, :color, :string
  end
end
