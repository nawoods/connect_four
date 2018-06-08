class Game
  attr_accessor :game_state
  
  def initialize
    self.game_state = [[nil] * 7] * 6
  end
end