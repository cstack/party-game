Rails.application.routes.draw do
  resources :game_users
  resources :movie_assignments
  resources :blanks
  resources :movies
  resources :games
	root 'welcome#index'
  resources :users
  resources :rooms do
    post 'start_game', to: 'rooms#start_game'
  	resources :messages
  	resources :room_users
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
