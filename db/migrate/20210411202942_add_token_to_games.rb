class AddTokenToGames < ActiveRecord::Migration[6.1]
  def change
  	add_column :games, :token, :string
  end
end
