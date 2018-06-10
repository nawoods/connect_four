class Game
  attr_reader :game_state
  
  def initialize
    @game_state = Array.new(6) { Array.new(7) }
  end

  def board_slot(row, col)
    @game_state[row-1][col-1]
  end
  
  def play(player, col)
    row = 1
    while !board_slot(row, col).nil?
      row += 1
      return false if row > 6
    end
    insert_chip(player, row, col)
  end

  def check_game_end
    check_horizontal_win || check_vertical_win || 
        check_diagonal_win(-1) || check_diagonal_win(1)
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

  def check_diagonal_win(slope)
    if slope == 1
      start_slots = [[3, 1], [2, 1], [1, 1], [1, 2], [1, 3], [1, 4]]
    elsif slope == -1
      start_slots = [[4, 1], [5, 1], [6, 1], [6, 2], [6, 3], [6, 4]]
    end
    rows = []
    start_slots.each { |start_slot| rows << diagonal_row(start_slot, slope) }
    rows.reduce(nil) { |acc, row| acc || check_array_win(row) }
  end

  def diagonal_row(start_slot, slope)
    all_slots = []
    i = 0
    while (1..6).include?(start_slot.first + (i * slope)) && 
        (1..7).include?(start_slot.last + i)
      all_slots << [start_slot.first + (i * slope), start_slot.last + i]
      i += 1
    end
    all_slots.map { |slot| board_slot(slot.first, slot.last) }
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
