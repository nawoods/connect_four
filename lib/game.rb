class Game
  attr_reader :game_state
  
  def initialize
    @game_state = Array.new(6) { Array.new(7) }
  end
  
  def to_s
    result = " 1 2 3 4 5 6 7\n"
    (1..6).to_a.reverse.each do |row|
      (1..7).to_a.each do |col|
        result += "|#{board_slot_s(row, col)}"
      end
      result += "|\n"
    end  
    result += "---------------"
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
        check_diagonal_win(-1) || check_diagonal_win(1) || check_draw
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
    (array.length - 3).times do |i|
      if !array[i].nil? && four_in_a_row_result(array.slice(i, 4))
        return array[i]
      end
    end
    nil
  end

  def four_in_a_row_result(array)
    chip1 = array[0]
    array.reduce(true) { |p, chip2| p && chip1 == chip2 }
  end

  # assume that all win conditions are checked first
  def check_draw
    :draw if @game_state.flatten.reduce(&:&)
  end
  
  def board_slot_s(row, col)
    case board_slot(row, col)
    when 1 then "o"
    when 2 then "x"
    when nil then " "
    end
  end
end
