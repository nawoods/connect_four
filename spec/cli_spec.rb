require_relative "../lib/cli.rb"
require_relative "./support/io_test_helpers.rb"

describe CLI do
  describe "#initialize" do
    context "when game is started" do
      subject { simulate_stdin(*%w(3 exit)) { CLI.new } }
      
      it "prints welcome message to console" do
        expect { subject }.to output(/W E L C O M E/).to_stdout
      end
    end
  end
  
  describe "#game_loop" do
    context "when game is started" do
      subject { simulate_stdin(*%w(3 exit)) { CLI.new } }
      it "creates a Game object" do
        expect(subject.game).to be_a(Game)
      end
    end
  end
  
  describe "#turn_loop" do
    
    context "on first turn" do
      subject do
        simulate_stdin(*%w(3 exit)) do
          cli = CLI.new
          cli.end_game = true
        end
      end
      
      it "prints current player number" do
        expect { subject }.to output(/PLAYER 1'S TURN/).to_stdout
      end

      it "prints game#to_s" do
        expect { subject }.to output(/1 2 3 4 5 6 7/).to_stdout
      end

      it "asks for column" do
        expect { subject }.to output(/In which column/).to_stdout
      end

      it "accepts user input for column number" do
        simulate_stdin(*%w(3 exit)) do
          cli = CLI.new
          expect(cli.game.to_s).to match(/\|o\|/)
        end
      end
    end
    
    context "on subsequent turns" do
      it "accepts user input for column numbers" do
        simulate_stdin(*%w(3 4 exit)) do
          cli = CLI.new
          expect(cli.game.to_s).to match(/\|o\|x\|/)
        end
      end
    end
  end
end
