require 'game'

class CLI
  attr_reader :game
  
  def initialize
    puts "W E L C O M E   T O   C O N N E C T   F O U R"
    game_loop
  end
  
  private
  
  def game_loop
    @game = Game.new
  end
  
  def turn_loop
  end
end