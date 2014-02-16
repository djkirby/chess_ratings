class Player < ActiveRecord::Base
	has_many :chess_games
end
