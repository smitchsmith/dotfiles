class Piece

  attr_accessor :coordinates, :board, :color

  def initialize(coordinates, board, color)
    @coordinates = coordinates
    @board = board
    @color = color
  end

  def dup
    self.class.new(@coordinates.dup, nil, color)
  end

  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end

  def move_into_check?(pos)
    duped_board = @board.dup
    duped_board.move!(coordinates, pos)
    duped_board.in_check?(color)
  end

  def capturable?(other_piece)
    color != other_piece.color
  end
end

class SlidingPiece < Piece

  def moves
    possible_moves = []

    move_dirs.each do |direction|
      case direction
      when "h_v"
        possible_moves += h_v_moves
      when "diagonal"
        possible_moves += diagonal
      end
    end

    possible_moves.uniq.reject{ |elem| elem == @coordinates }
  end

  def h_v_moves
    possible_moves = []
    search_generator.each do |search|
      search.each do |ele|
        if @board[ele]
          possible_moves << ele if capturable?(@board[ele])
          break
        else
          possible_moves << ele
        end
      end
    end

    possible_moves
  end

  def search_generator
    x, y = @coordinates
    searches = []

    searches << ((y + 1)..7).to_a.map { |i| [x,i] }
    searches << (y - 1).downto(0).to_a.map { |i| [x,i] }
    searches << ((x + 1)..7).to_a.map { |i| [i,y] }
    searches << (x - 1).downto(0).to_a.map { |i| [i,y] }

    searches
  end

  def diagonal
    possible_moves = []
    operators = [[:+, :+], [:+, :-], [:-, :+], [:-, :-]]

    operators.each do |op|
      x, y = @coordinates

      until x > 7 || x < 0 || y > 7 || y < 0
        if @board[[x, y]] && @board[[x, y]] != self
          possible_moves << [x, y] if capturable?(@board[[x, y]])
          break
        else
          possible_moves << [x, y]
          x, y = x.send(op[0], 1), y.send(op[1], 1)
        end
      end
    end

    possible_moves
  end

end

class SteppingPiece < Piece
  def moves
    x, y = @coordinates
    possible_moves = move_dirs.map{ |dir| [dir[0] + x, dir[1] + y]}
    possible_moves.select do |move|
      next unless move[0].between?(0,7) && move[1].between?(0,7)
      !@board[move] || capturable?(@board[move])
    end
  end
end

class Bishop < SlidingPiece
  def move_dirs
    ["diagonal"]
  end
end

class Rook < SlidingPiece
  def move_dirs
    ["h_v"]
  end
end

class Queen < SlidingPiece
  def move_dirs
    ["h_v", "diagonal"]
  end
end

class Knight < SteppingPiece
  def move_dirs
    [
      [1,2],
      [1,-2],
      [-1, 2],
      [-1, -2],
      [2, -1],
      [2, 1],
      [-2, -1],
      [-2, 1]
    ]
  end
end

class King < SteppingPiece
  def move_dirs
    [
      [1,1],
      [1,0],
      [1,-1],
      [-1, 1],
      [-1, 0],
      [-1, -1],
      [0, -1],
      [0, 1]
    ]
  end
end

class Pawn < Piece

  def moves
    x, y = @coordinates
    possible_moves = [first_move(x, y)]

    # Check squares one rank forward
    color == :black ? x += 1 : x -= 1

    possible_moves << [x, y] unless @board[[x,y]]
    possible_moves += pawn_captures(x, y)

    possible_moves.reject { |pairs| pairs.empty? }
  end

  def pawn_captures(x, y)
    left_right = []
    left_right << @board[[x, y - 1]] if (y - 1).between?(0,7)
    left_right << @board[[x, y + 1]] if (y + 1).between?(0,7)
    left_right.select { |tile| capturable?(tile) rescue false }
  end

  def first_move(x, y)
    pawn_starts = {:white => [6, 4], :black => [1, 3]}
    x_coord = pawn_starts[color][1]
    (pawn_starts[color][0] != x || @board[[x_coord, y]]) ? [] : [x_coord, y]
  end
end