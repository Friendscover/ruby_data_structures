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
  attr_accessor :game_board, :next_moves

  def initialize
    @game_board = Board.new
  end

  def set_position(x, y, value)
    @game_board.board[x][y] = value
    @game_board.print_board
  end

  def knight_moves(start_position, end_position)
    @next_moves = generate_moves(start_position)
    if start_position == end_position
      return
    end
  end

  def generate_moves(position)
  end
end

k1 = Knight.new
k1.set_position(0, 0, 2)
k1.generate_moves([0, 0])
