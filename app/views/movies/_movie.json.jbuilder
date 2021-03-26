json.extract! movie, :id, :game_id, :created_at, :updated_at
json.url movie_url(movie, format: :json)
