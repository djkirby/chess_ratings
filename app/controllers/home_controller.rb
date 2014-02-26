class HomeController < ApplicationController
	def index
		rated_players = Player.order(rating: :desc).all.select { |p| p.getRating != 'PRO' }
		provisional_players = Player.order(rating: :desc).all.select { |p| p.getRating == 'PRO' }

		@players = rated_players + provisional_players
		@chess_games = ChessGame.all.order(created_at: :desc)
	end
end
