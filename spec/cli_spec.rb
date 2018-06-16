require_relative "../lib/cli.rb"
require_relative "./support/io_test_helpers.rb"

describe CLI do
  describe "#initialize" do
    context "when game is started" do
      subject { simulate_stdin(*%w(3 exit n)) { CLI.new } }
      
      it "prints welcome message to console" do
        expect { subject }.to output(/W E L C O M E/).to_stdout
      end
    end
  end
  
  describe "#game_loop" do
    context "when game is started" do
      subject { simulate_stdin(*%w(3 exit n)) { CLI.new } }
      it "creates a Game object" do
        expect(subject.game).to be_a(Game)
      end
    end
  end
  
  describe "#turn_loop" do
    
    context "on first turn" do
      subject do
        simulate_stdin(*%w(3 exit n)) do
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
        simulate_stdin(*%w(3 exit n)) do
          cli = CLI.new
          expect(cli.game.to_s).to match(/\|o\|/)
        end
      end
    end
    
    context "on subsequent turns" do
      it "accepts user input for column numbers" do
        simulate_stdin(*%w(3 4 exit n)) do
          cli = CLI.new
          expect(cli.game.to_s).to match(/\|o\|x\|/)
        end
      end
    end
    
    context "when player 1 wins" do
      subject { simulate_stdin(*%w(3 4 3 4 3 4 3 n)) { CLI.new } }
      
      it "prints a congratulations message" do
        expect { subject }.to output(/Congrats! Player 1 wins!/).to_stdout
      end
    end
    
    context "when player 2 wins" do
      subject { simulate_stdin(*%w(1 3 4 3 4 3 4 3 n)) { CLI.new } }
      
      it "prints a congratulations message" do
        expect { subject }.to output(/Congrats! Player 2 wins!/).to_stdout
      end
    end
    
    context "when game is drawn" do
      subject do
        input = []
        [1, 2, 3, 6, 7].each { |i| 6.times { input << i } }
        input << 5
        6.times { input << 4 }
        5.times { input << 5 }
        input << 'n'
        simulate_stdin(*input) { CLI.new }
      end
      
      it "announces a draw game" do
        expect { subject }.to output(/Draw game!/).to_stdout
      end
    end
    
    context "at end of game" do
      subject { simulate_stdin(*%w(3 4 3 4 3 4 3 n)) { CLI.new } }
      
      it "asks if player wants to play again" do
        expect { subject }.to output(/Play again?/).to_stdout
      end
    end
    
    context "during second game" do
      subject do
        input = %w(3 4 3 4 3 4 3 y 1 3 4 3 4 3 4 3 n)
        simulate_stdin(*input) { CLI.new }
      end
      
      it "outputs player 2's victory message" do
        expect { subject }.to output(/Congrats! Player 1 wins!/).to_stdout
      end
    end
  end
end
