require 'game'

class CLI
  attr_reader :game
  
  def initialize
    puts "W E L C O M E   T O   C O N N E C T   F O U R"
    @game = Game.new
  end
end