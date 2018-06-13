require_relative "../lib/cli.rb"

describe CLI do
  describe "#initialize" do
    context "when game is started" do
      it "prints welcome message to console" do
        expect { CLI.new }.to output(/W E L C O M E/).to_stdout
      end
    end
  end
  
  describe "#game_loop" do
    context "when game is started" do
      it "creates a Game object" do
        expect(CLI.new.game).to be_a(Game)
      end
    end
  end
  
#  describe "#turn_loop" do
#    context "on first turn" do
#      it "outputs current player number" do
#        excpect { CLI.new }.to output(/PLAYER 1'S TURN/).to_stdout
#      end
#    end
#  end
end