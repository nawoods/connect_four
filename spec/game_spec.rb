require_relative "../lib/game.rb"

describe Game do
  describe "#initialize" do
    it "creates a game grid" do
      expect(Game.new.game_state).to eq([[nil] * 7] * 6)
    end
  end
  
  describe "#to_s" do
    context "at beginning of game" do
      it "displays an empty game board" do
        expect(Game.new.to_s).to eq(" 1 2 3 4 5 6 7\n"\
                                    "| | | | | | | |\n"\
                                    "| | | | | | | |\n"\
                                    "| | | | | | | |\n"\
                                    "| | | | | | | |\n"\
                                    "| | | | | | | |\n"\
                                    "| | | | | | | |\n"\
                                    "---------------")
      end
    end
    
    context "in the middle of a game" do
      subject do
        game = Game.new
        
        game.play(6)
        game.play(6)
        
        game.play(3)
        game.play(3)
        game.play(3)
        game.play(3)
        game.play(3)
        
        game
      end
      it "displays board with placed chips" do
        expect(subject.to_s).to eq(" 1 2 3 4 5 6 7\n"\
                                    "| | | | | | | |\n"\
                                    "| | |o| | | | |\n"\
                                    "| | |x| | | | |\n"\
                                    "| | |o| | | | |\n"\
                                    "| | |x| | |x| |\n"\
                                    "| | |o| | |o| |\n"\
                                    "---------------")
      end
    end
  end

  describe "#board_slot" do
    context "when slot is empty" do
      subject { Game.new.board_slot(6,3) }

      it "returns nil" do
        expect(subject).to eq(nil)
      end
    end

    context "when slot is nonempty" do
      subject do
        game = Game.new
        game.play(4)
        game.board_slot(1, 4)
      end

      it "returns player number" do
        expect(subject).to eq(1)
      end
    end
  end
  
  describe "#play" do
    context "when given column is empty" do
      subject do
        game = Game.new
        game.play(4)
        game.board_slot(1, 4)
      end
      
      it "adds a piece to the bottom row" do
        expect(subject).to eq(1)
      end
    end
  
  
    context "when given column is neither empty nor full" do
      subject do
        game = Game.new
        2.times { game.play(6) }
        5.times { game.play(3) }
        game
      end
      
      it "adds a piece to the correct row" do
        expect(subject.board_slot(2, 6)).to eq(2)
        expect(subject.board_slot(5, 3)).to eq(1)
      end
    end
    
    context "when given column is full" do
      subject do
        game = Game.new
        game2 = Game.new
        6.times { game.play(5) }
        7.times { game2.play(5) }
        [game.game_state, game2.game_state]
      end
      
      it "does not change game_state" do
        expect(subject.first).to eq(subject.last)
      end
    end
  end

  describe "#check_game_end" do
    context "when no winner yet" do
      subject { Game.new.check_game_end }

      it "returns nil" do
        expect(subject).to eq(nil)
      end
    end

    context "when game has been won horizontally" do
      subject do
        game = Game.new
        4.times do |i|
          game.play(i+1)
          game.play(5) unless i == 3
        end
        game.check_game_end
      end

      it "returns number of winning player" do
        expect(subject).to eq(1)
      end
    end

    context "when game has been won vertically" do
      subject do
        game = Game.new
        game.play(1)
        4.times do |i|
          game.play(3)
          game.play(5) unless i == 3
        end
        game.check_game_end
      end

      it "returns number of winning player" do
        expect(subject).to eq(2)
      end
    end

    context "when game has been won diagonally (/)" do
      subject do
        game = Game.new

        game.play(1)
        2.times { game.play(2) }
        game.play(1)
        3.times { game.play(3) }
        4.times { game.play(4) }

        game.check_game_end
      end

      it "returns number of winning player" do
        expect(subject).to eq(1)
      end
    end

    context "when game has been won diagonally (\)" do
      subject do
        game = Game.new

        game.play(7)
        2.times { game.play(6) }
        game.play(1)
        3.times { game.play(5) }
        4.times { game.play(4) }

        game.check_game_end
      end

      it "returns number of winning player" do
        expect(subject).to eq(1)
      end
    end

    context "when game board is full" do
      subject do
        game = Game.new

        3.times { |i| 6.times { game.play(i+1) } }
        game.play(5)
        6.times { game.play(4) }
        5.times { game.play(5) }
        2.times { |i| 6.times { game.play(i+6) } }
        puts game
        game.check_game_end
      end

      it "returns :draw" do
        expect(subject).to eq(:draw)
      end
    end
  end
end
