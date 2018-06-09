class Game
  attr_accessor :game_state
  
  def initialize
    @game_state = Array.new(6) { Array.new(7) }
  end

  def board_slot(row, col)
    @game_state[row-1][col-1]
  end
  
  def play(player, col)
    row = 6
    while !board_slot(row, col).nil?
      row -= 1
      return false if row < 1
    end
    insert_chip(player, row, col)
  end

  def check_game_end
    check_horizontal_win || check_vertical_win
  end

  private

  def insert_chip(player, row, col)
    @game_state[row-1][col-1] = player
  end

  def check_horizontal_win
    (1..6).to_a.reduce(nil) do |acc, row| 
      acc || check_array_win((1..7).to_a.map { |col| board_slot(row, col) })
    end
  end
  
  def check_vertical_win
    (1..7).to_a.reduce(nil) do |acc, col| 
      acc || check_array_win((1..6).to_a.map { |row| board_slot(row, col) })
    end
  end

  def check_array_win(array)
    array.slice(0, array.length - 3).each_with_index do |chip1, i|
      if array.slice(i+1, 3).reduce(true) { |p, chip2| p && chip1  == chip2 }
        return chip1
      end
    end
    nil
  end
    
end
