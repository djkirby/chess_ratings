class RemoveIdFromChessGame < ActiveRecord::Migration
  def change
  	remove_column :chess_games, :id
  end
end
