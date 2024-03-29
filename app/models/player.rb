class Player < ActiveRecord::Base
	has_many :chess_games # destroy dependent?

	STARTING_RATING = 1450
	GAMES_WHILE_PROVISIONAL = 4

	def getWins
		games = self.getGames
		return games.where("winner_id = ?", self.id).count
	end

	def getLosses
		games = self.getGames
		return games.where("winner_id != ?", self.id).count
	end

	def getStaleMates
		games = self.getGames
		return games.where("winner_id = 0").count
	end

	def getGames
		return ChessGame.where("white_player_id = ? or black_player_id = ?", self.id, self.id)
	end

	def getRating
		if self.getGames.count < GAMES_WHILE_PROVISIONAL
			return 'PRO'
		else
			return self.rating
		end
	end
end
