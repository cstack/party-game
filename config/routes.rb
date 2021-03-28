Rails.application.routes.draw do
  resources :votes
  resources :game_users
  resources :movie_assignments
  resources :blanks
  resources :movies
  resources :games do
    post 'fill_in_the_blank', to: 'games#fill_in_the_blank'
    post 'vote', to: 'games#vote'
  end
	root 'welcome#index'
  resources :users
  resources :rooms do
    post 'start_game', to: 'rooms#start_game'
    post 'join', to: 'rooms#join'
    post 'test_broadcast', to: 'rooms#test_broadcast'
  	resources :messages
  	resources :room_users
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
