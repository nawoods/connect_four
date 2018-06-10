require_relative "../lib/game.rb"

describe Game do
  describe "#initialize" do
    it "creates a game grid" do
      expect(Game.new.game_state).to eq([[nil] * 7] * 6)
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
        game.play(1, 4)
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
        game.play(1, 4)
        game.board_slot(1, 4)
      end
      
      it "adds a piece to the bottom row" do
        expect(subject).to eq(1)
      end
    end
  
  
    context "when given column is neither empty nor full" do
      subject do
        game = Game.new
        
        game.play(1, 6)
        game.play(2, 6)
        
        game.play(1, 3)
        game.play(2, 3)
        game.play(1, 3)
        game.play(2, 3)
        game.play(1, 3)
        
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
        
        i = 1
        6.times do
          game.play(i, 5)
          i = (i + 1) % 2
        end
        
        i = 1
        7.times do
          game2.play(i, 5)
          i = (i + 1) % 2
        end
        
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
          game.play(1, i+1)
          game.play(2, 5) unless i == 3
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
        game.play(1, 1)
        4.times do |i|
          game.play(2, 3)
          game.play(1, 5) unless i == 3
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

        game.play(1, 1)

        game.play(2, 2)
        game.play(1, 2)
        
        game.play(2, 1)
        game.play(1, 3)
        game.play(2, 3)
        game.play(1, 3)

        game.play(2, 4)
        game.play(1, 4)
        game.play(2, 4)
        game.play(1, 4)

        game.check_game_end
      end

      it "returns number of winning player" do
        expect(subject).to eq(1)
      end
    end

    context "when game has been won diagonally (\)" do
      subject do
        game = Game.new

        game.play(1, 7)

        game.play(2, 6)
        game.play(1, 6)
        
        game.play(2, 1)
        game.play(1, 5)
        game.play(2, 5)
        game.play(1, 5)

        game.play(2, 4)
        game.play(1, 4)
        game.play(2, 4)
        game.play(1, 4)

        game.check_game_end
      end

      it "returns number of winning player" do
        expect(subject).to eq(1)
      end
    end
  end
end
