class ChessGame < ActiveRecord::Base
	belongs_to :white_player, :class_name => 'Player', :foreign_key => 'white_player_id'
  	belongs_to :black_player, :class_name => 'Player', :foreign_key => 'black_player_id'

  	def updatePlayerRatings
  		white_player.updateRating(self)
  		black_player.updateRating(self)
  	end

  	def getWinner
  		if self.winner_id == 0
  			return nil
  		elsif Player.find(self.winner_id) == self.white_player 
  			return self.white_player
  		elsif Player.find(self.winner_id) == self.black_player
  			return self.black_player
  		end
  	end

  	def getLoser
  		if self.winner_id == 0
  			return nil
		elsif Player.find(self.winner_id) == self.white_player 
  			return self.black_player
  		elsif Player.find(self.winner_id) == self.black_player
  			return self.white_player
  		end
  	end
end
