class HomeController < ApplicationController
	def index
		rated_players = Player.all.select { |p| p.getRating != 'PRO' }
		provisional_players = Player.all.select { |p| p.getRating == 'PRO' }

		@players = rated_players + provisional_players
		@chess_games = ChessGame.all
	end
end
