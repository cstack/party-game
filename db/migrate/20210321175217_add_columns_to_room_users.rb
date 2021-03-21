class AddColumnsToRoomUsers < ActiveRecord::Migration[6.1]
  def change
  	add_column :room_users, :room_id, :integer
  	add_column :room_users, :user_id, :integer
  	add_index :room_users, [:room_id, :user_id], unique: true
  end
end
