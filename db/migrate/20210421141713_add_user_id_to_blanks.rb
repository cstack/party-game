class AddUserIdToBlanks < ActiveRecord::Migration[6.1]
  def change
  	add_column :blanks, :user_id, :integer
  	add_index :blanks, :user_id
  end
end
