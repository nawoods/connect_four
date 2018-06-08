require_relative "../lib/game.rb"

describe Game do
  describe "#initialize" do
    it "creates a game grid" do
      expect(Game.new.game_state).to eq([[nil] * 7] * 6)
    end
  end
end