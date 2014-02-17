class HomeController < ApplicationController
	def index
		@players = Player.order(rating: :desc)
		@chess_games = ChessGame.all
	end
end
