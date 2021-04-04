class AddTokenToRoom < ActiveRecord::Migration[6.1]
  def change
  	add_column :rooms, :token, :string
  end
end
