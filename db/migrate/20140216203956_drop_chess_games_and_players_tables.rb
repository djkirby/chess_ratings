class DropChessGamesAndPlayersTables < ActiveRecord::Migration
  def change
  	drop_table :players
  	drop_table :chess_games
  end
end
