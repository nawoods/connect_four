require_relative './game'
require_relative './prompt'

class CLI
  attr_reader :game
  attr_accessor :end_game

  include Prompt
  
  def initialize
    @end_game = false
    @new_game = true
    puts "W E L C O M E   T O   C O N N E C T   F O U R"
    game_loop while @new_game
  end
  
  private
  
  def game_loop
    @game = Game.new
    turn_loop until game.check_game_end || @end_game
    puts end_game_message
    @new_game = false if prompt("Play again? (y/n) ", /^[yn]/i) =~ /^n/i
  end
  
  def turn_loop
    puts "PLAYER #{game.current_player}'S TURN"
    puts @game
    choice = prompt("In which column would you like to play? (1-7) ",
                    /^[1-7|exit]/)
    @end_game = true if choice == "exit"
    @game.play(choice.to_i)
  end
  
  def end_game_message
    puts game.to_s
    return "Draw game!" if game.check_game_end == :draw
    "Congrats! Player #{game.check_game_end} wins!"
  end
end