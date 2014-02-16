ChessRatings::Application.routes.draw do
	root 'home#index'
  	resources :chess_games
  	resources :players
end
