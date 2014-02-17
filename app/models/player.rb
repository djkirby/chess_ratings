class Player < ActiveRecord::Base
	has_many :chess_games

	STARTING_RATING = 1450

	def updateRating(chess_game)
		white_player = chess_game.white_player
		black_player = chess_game.black_player
		if chess_game.winner_id != 0
			winner = chess_game.getWinner
			loser = chess_game.getLoser
		else
			winner = (white_player.rating > black_player.rating ? white_player : black_player)
			loser = (winner == white_player ? black_player : white_player)
		end
		rating_disparity = 400
		game_outcome = 0.5 # Stale mate
		if chess_game.getWinner == self # Player won
			game_outcome = 1
		elsif chess_game.getLoser == self # Player lost
			game_outcome = 0
		end
		score_difference = (white_player.rating - black_player.rating).abs
		k_factor = 0
		if white_player.rating < 2100 or black_player.rating < 2100
			k_factor = 32
		elsif white_player.rating 2401 or black_player.rating < 2401
			k_factor = 24
		elsif white_player.rating > 2400 and black_player.rating > 2400
			k_factor = 16
		end
		delta_rating = k_factor * (game_outcome - (1 / (10 ^ (-score_difference / rating_disparity) + 1)))
		winner.update_attribute(:rating, winner.rating + delta_rating)
		loser.update_attribute(:rating, loser.rating - delta_rating)
	end
end