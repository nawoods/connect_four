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
  
  describe "#turn_loop" do
    context "on first turn" do
      it "prints current player number" do
        expect { CLI.new }.to output(/PLAYER 1'S TURN/).to_stdout
      end

      it "prints game#to_s" do
        expect { CLI.new }.to output(/1 2 3 4 5 6 7/).to_stdout
      end

      it "asks for column" do
        expect { CLI.new }.to output(/In which column/).to_stdout
      end

      it "accepts user input for column number" do
        cli = CLI.new
        allow(cli).to receive(:gets).and_return("3")
        expect(cli.game.to_s).to match(/\|o\|/)
      end
    end
  end
end
