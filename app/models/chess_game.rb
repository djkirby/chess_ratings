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
      else
        return Player.find(self.winner_id)
  		end
  	end

  	def getLoser
  		if self.winner_id == 0
  			return nil
      elsif self.getWinner == self.white_player
        return self.black_player
      else
        return self.white_player
      end
  	end
end
