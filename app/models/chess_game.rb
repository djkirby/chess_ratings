class ChessGame < ActiveRecord::Base
	belongs_to :white_player, :class_name => 'Player', :foreign_key => 'white_player_id'
  	belongs_to :black_player, :class_name => 'Player', :foreign_key => 'black_player_id'
end
