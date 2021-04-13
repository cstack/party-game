class RenameMoviesToStories < ActiveRecord::Migration[6.1]
  def change
  	rename_table :movies, :stories

  	remove_index :blanks, name: "index_blanks_on_movie_id"
  	rename_column :blanks, :movie_id, :story_id
  	add_index :blanks, :story_id

  	remove_index :movie_assignments, name: "index_movie_assignments_on_movie_id"
  	rename_column :movie_assignments, :movie_id, :story_id
  	add_index :movie_assignments, :story_id

  	remove_index :votes, name: "index_votes_on_movie_id"
  	rename_column :votes, :movie_id, :story_id
  	add_index :votes, :story_id

  	rename_table :movie_assignments, :assignments
  end
end
