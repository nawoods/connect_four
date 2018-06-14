require_relative './game'
require_relative './prompt'

class CLI
  attr_reader :game

  include Prompt
  
  def initialize
    puts "W E L C O M E   T O   C O N N E C T   F O U R"
    game_loop
  end
  
  private
  
  def game_loop
    @game = Game.new
    turn_loop # until game.check_game_end
  end
  
  def turn_loop
    puts "PLAYER #{game.current_player}'S TURN"
    puts @game
    choice = prompt("In which column would you like to play? (1-7) ", /^[1-7]/)
    @game.play(choice.to_i)
  end
end
