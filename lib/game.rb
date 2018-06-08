class Game
  attr_accessor :game_state
  
  def initialize
    @game_state = Array.new(6) { Array.new(7) }
  end
  
  def play(player, column)
    i = 5
    while !@game_state[i][column - 1].nil?
      i -= 1
      return false if i < 0
    end
    @game_state[i][column - 1] = player
  end
end