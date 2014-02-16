class ChangeChessGameIdType < ActiveRecord::Migration
  def change
  	change_column :chess_games, :id, :integer
  end
end
