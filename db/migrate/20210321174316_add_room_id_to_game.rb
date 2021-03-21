class AddRoomIdToGame < ActiveRecord::Migration[6.1]
  def change
  	add_column :games, :room_id, :integer
  end
end
