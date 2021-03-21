Rails.application.routes.draw do
  resources :games
	root 'welcome#index'
  resources :users
  resources :rooms do
  	resources :messages
  	resources :room_users
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
