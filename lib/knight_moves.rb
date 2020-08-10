#simplest way to get from one square to another
#output all squares along the way
#board 2 dimensional coordinates
#[0, 0], [1,2]
#all possible moves as a child, out of board => exit
#adjacency list > all possible moves displayed as 2d array
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
    #set node as start_position
    #generate moves for node => check if new node is goal?
    #queue the nodes
    #else generate new node for current position
    #needs to have a better way to define depth of tree/shortest distance to end
    queue = []
    counter = 0
    queue << start_position

    until queue.nil?
      counter += 1
      position = queue.shift

      if position == end_position
        return "It took #{counter} steps to find #{position}"
      else
        next_positions = generate_moves(position)

        next_positions.each do |position|
          queue << position
        end
      end
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


