class ChessGamesController < ApplicationController
  before_action :set_chess_game, only: [:show, :edit, :update, :destroy]

  # GET /chess_games
  # GET /chess_games.json
  def index
    @chess_games = ChessGame.all
  end

  # GET /chess_games/1
  # GET /chess_games/1.json
  def show
  end

  # GET /chess_games/new
  def new
    @chess_game = ChessGame.new
  end

  # GET /chess_games/1/edit
  def edit
  end

  # POST /chess_games
  # POST /chess_games.json
  def create
    @chess_game = ChessGame.new(chess_game_params)

    respond_to do |format|
      if @chess_game.save
        format.html { redirect_to @chess_game, notice: 'Chess game was successfully created.' }
        format.json { render action: 'show', status: :created, location: @chess_game }
      else
        format.html { render action: 'new' }
        format.json { render json: @chess_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chess_games/1
  # PATCH/PUT /chess_games/1.json
  def update
    respond_to do |format|
      if @chess_game.update(chess_game_params)
        format.html { redirect_to @chess_game, notice: 'Chess game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @chess_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chess_games/1
  # DELETE /chess_games/1.json
  def destroy
    @chess_game.destroy
    respond_to do |format|
      format.html { redirect_to chess_games_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chess_game
      @chess_game = ChessGame.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chess_game_params
      params.require(:chess_game).permit(:white_player_id, :black_player_id, :winner_id)
    end
end
