json.array!(@chess_games) do |chess_game|
  json.extract! chess_game, :id, :white_player_id, :black_player_id, :winner_id
  json.url chess_game_url(chess_game, format: :json)
end
