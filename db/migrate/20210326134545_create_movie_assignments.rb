class CreateMovieAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_assignments do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
