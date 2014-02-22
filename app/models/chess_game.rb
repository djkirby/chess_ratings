class ChessGame < ActiveRecord::Base
	belongs_to :white_player, :class_name => 'Player', :foreign_key => 'white_player_id'
  	belongs_to :black_player, :class_name => 'Player', :foreign_key => 'black_player_id'

    def self.updatePlayerRatings!
        ratings = {}
        ChessGame.all.each do |chess_game|
            white_player = chess_game.white_player
            black_player = chess_game.black_player
            player1 = (white_player.rating > black_player.rating ? white_player : black_player)
            player2 = (player1 == white_player ? black_player : white_player)
            if !ratings.has_key?(player1.id)
                ratings[player1.id] = Player::STARTING_RATING
            end 
            if !ratings.has_key?(player2.id)
                ratings[player2.id] = Player::STARTING_RATING
            end

            winner = chess_game.getWinner
            loser = chess_game.getLoser
            delta_elo = 0
            if winner == player1
                delta_elo = chess_game.calculateDeltaEloRating(ratings, 1)
            elsif winner == player2
                delta_elo = chess_game.calculateDeltaEloRating(ratings, 0)
            else
                delta_elo = chess_game.calculateDeltaEloRating(ratings, 0.5)
            end
            logger.debug "___ #{player1.name} (#{ratings[player1.id]}->#{ratings[player1.id] + delta_elo}) vs #{player2.name} (#{ratings[player2.id]}->#{ratings[player2.id] - delta_elo})"
            ratings[player1.id] = (ratings[player1.id] + delta_elo).floor
            ratings[player2.id] = (ratings[player2.id] - delta_elo).floor
            logger.debug "___ "
        end

        Player.all.each do |player|
            if !ratings.has_key?(player.id)
                player.destroy
            else
                player.update_attribute :rating, ratings[player.id]
            end
        end
    end

    def calculateDeltaEloRating(ratings, game_outcome)
        white_player = self.white_player
        black_player = self.black_player
        player1 = (white_player.rating > black_player.rating ? white_player : black_player)
        player2 = (player1 == white_player ? black_player : white_player)
        if self.winner_id != 0
            winner = self.getWinner
            loser = self.getLoser
        else
            winner = (ratings[white_player.id] > ratings[black_player.id] ? white_player : black_player)
            loser = (winner == white_player ? black_player : white_player)
        end
        rating_disparity = 400
        score_difference = ratings[player1.id] - ratings[player2.id]
        k_factor = 0
        if ratings[white_player.id] < 2100 or ratings[black_player.id] < 2100
            k_factor = 32
        elsif ratings[white_player.id] < 2401 or ratings[black_player.id] < 2401
            k_factor = 24
        elsif ratings[white_player.id] > 2400 and ratings[black_player.id] > 2400
            k_factor = 16
        end
        delta_rating = (k_factor * (game_outcome - (1.0 / (10.0 ** (-score_difference.to_f / rating_disparity.to_f) + 1))))
        logger.debug "___ k_factor=#{k_factor} game_outcome=#{game_outcome} score_difference=#{score_difference} rating_disparity=#{rating_disparity}"
        logger.debug "___ delta_rating=#{delta_rating}"
        return delta_rating
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
