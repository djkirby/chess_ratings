require "spec_helper"

describe ChessGamesController do
  describe "routing" do

    it "routes to #index" do
      get("/chess_games").should route_to("chess_games#index")
    end

    it "routes to #new" do
      get("/chess_games/new").should route_to("chess_games#new")
    end

    it "routes to #show" do
      get("/chess_games/1").should route_to("chess_games#show", :id => "1")
    end

    it "routes to #edit" do
      get("/chess_games/1/edit").should route_to("chess_games#edit", :id => "1")
    end

    it "routes to #create" do
      post("/chess_games").should route_to("chess_games#create")
    end

    it "routes to #update" do
      put("/chess_games/1").should route_to("chess_games#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/chess_games/1").should route_to("chess_games#destroy", :id => "1")
    end

  end
end
