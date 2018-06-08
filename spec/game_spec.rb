require_relative "../lib/game.rb"

describe Game do
  describe "#initialize" do
    it "creates a game grid" do
      expect(Game.new.game_state).to eq([[nil] * 7] * 6)
    end
  end
  
  describe "#play" do
    context "when given column is empty" do
      subject do
        game = Game.new
        game.play(1, 4)
        game.game_state
      end
      
      it "adds a piece to the bottom row" do
        expect(subject[5][3]).to eq(1)
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
        
        game.game_state
      end
      
      it "adds a piece to the correct row" do
        expect(subject[4][5]).to eq(2)
        expect(subject[1][2]).to eq(1)
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
end