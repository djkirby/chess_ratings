class AddDateToChessGames < ActiveRecord::Migration
  def change
  	add_column :chess_games, :date, :date
  end
end
