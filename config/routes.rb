Rails.application.routes.draw do
  root 'welcome#index'
  resources :stories, only: [:show]
  resources :games, only: [:show] do
    post 'fill_in_the_blank', to: 'games#fill_in_the_blank'
    post 'change_answer', to: 'games#change_answer'
    post 'vote', to: 'games#vote'
    post 'restart', to: 'games#restart'
  end
  resources :rooms, only: [:show, :create] do
    resources :room_users, only: [:edit, :update, :show]
    post 'start_game', to: 'rooms#start_game'
    post 'finish_game', to: 'rooms#finish_game'
    post 'join', to: 'rooms#join'
    post 'test_broadcast', to: 'rooms#test_broadcast'
  end
  resources :users, only: [:edit, :update, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
