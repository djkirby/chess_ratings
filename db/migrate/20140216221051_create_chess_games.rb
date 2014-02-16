class CreateChessGames < ActiveRecord::Migration
  def change
    create_table :chess_games do |t|
      t.integer :white_player_id
      t.integer :black_player_id
      t.integer :winner_id

      t.timestamps
    end
  end
end
