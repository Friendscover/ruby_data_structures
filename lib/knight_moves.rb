class Board
  attr_accessor :board 

  def initialize
  @board = Array.new(8) { Array.new(8) }
  end

  def print_board
    @board.each { |elements| p elements }
  end
end

class Knight
  attr_accessor :game_board

  def initialize
    @game_board = Board.new
  end

  def set_position(x, y, value)
    @game_board.board[x][y] = value
    @game_board.print_board
  end

  def knight_moves(start_position, end_position)
    queue = []
    adj_list = [[start_position]]
    i = 0

    loop do 
      #put the new moves in queue to generate moves out of that position
      adj_list[i].each do |move|
        queue << move
      end
      
      i += 1
      
      until queue.empty?
        move = queue.shift 
        #temp array to store all moves to add it at level i of the adj list
        #for each move 
        temp = []

        move.each do |position|
          new_position = generate_moves(position)
          temp << new_position
          #remove duplicate moves if two moves land on the same positon
          temp.uniq!
        end

        adj_list << temp

        if check_end_position(temp, end_position)
          print_path(adj_list, end_position)
          return #"#{end_position} #{adj_list.length - 1}" 
        end
      end
    end
  end

  def check_end_position(array, end_position)
    array.each do |element|
      if element.include?(end_position)
        return true
      end
    end
    return false
  end

  def print_path(list, end_position)
    return_index = 0

    #gets the index of the end_position in the list
    list.each_with_index do |position, index|
      position.each do |move|
        if move.include?(end_position)
          return_index = index
        end
      end
    end

    p "Test: #{return_index}"
    list.each do |element|
      temp = element
    end
    
  end

  def generate_moves(position)
    row = position[0]
    column = position[1]
    possible_moves = []
    
    possible_moves << arr = [row + 2, column + 1] 
    possible_moves << arr = [row + 2, column - 1] 
    possible_moves << arr = [row - 2, column + 1] 
    possible_moves << arr = [row - 2, column - 1] 
    possible_moves << arr = [row + 1, column + 2] 
    possible_moves << arr = [row + 1, column - 2] 
    possible_moves << arr = [row - 1, column + 2] 
    possible_moves << arr = [row - 1, column - 2] 

    #removes the moves that are not possible for the knight to do 
    remove_outside_elements(possible_moves)
  end

  def remove_outside_elements(array)
    possible_moves = []
    array.each do |element|
      if element[0] > 7 || element[0] < 0 || element[1] > 7 || element[1] < 0
        next
      else 
        possible_moves << element
      end
    end
    return possible_moves
  end
end

k1 = Knight.new
#k1.set_position(0, 0, 2)
p k1.knight_moves([0, 0],[1, 2])
p k1.knight_moves([0, 0],[3, 3])
#p k1.generate_moves([0, 0])
#p k1.knight_moves([0, 0], [3, 3])
p k1.knight_moves([3, 3], [4, 3])