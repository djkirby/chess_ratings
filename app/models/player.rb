class Player < ActiveRecord::Base
	has_many :chess_games # destroy dependent?

	STARTING_RATING = 1450
end