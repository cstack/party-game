json.extract! movie_assignment, :id, :movie_id, :user_id, :game_id, :created_at, :updated_at
json.url movie_assignment_url(movie_assignment, format: :json)
