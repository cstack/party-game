class CreateGameUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :game_users do |t|
      t.references :game, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
