# encoding: UTF-8
class InvalidInputError < StandardError
end

class InvalidMoveError < InvalidInputError
end

class InvalidCoordinateError < InvalidInputError
end

class Piece
  F_MOVES = [[1,1],[1,-1]]
  B_MOVES = [[-1,1],[-1,-1]]

  attr_accessor :board
  attr_reader :color

  def initialize(color, board, x, y, king = false)
    @king = king
    @color = color
    @board = board
    @coordinates = [x, y]
  end

  def perform_moves(move_sequence)
    if valid_move_seq?(move_sequence)
      perform_moves!(move_sequence)
    else
      raise InvalidMoveError
    end
    maybe_promote?
  end

  def x
    @coordinates[0]
  end

  def y
    @coordinates[1]
  end

  def dup
    Piece.new(@color, nil, self.x, self.y, @king)
  end

  def perform_moves!(move_sequence)
    move_sequence.each do |move|
      x, y = move
      moved = perform_slide(x, y) if move_sequence.count == 1
      moved = perform_jump(x, y) unless moved
      raise InvalidMoveError unless moved
    end
  end

  def to_utf8
      if @king
        color == :red ? "♚" : "♔"
      else
        color == :red ? "♟" : "♙"
      end
  end

  private

  def valid_move_seq?(move_sequence)
    duped_piece = self.dup
    duped_board = @board.dup.add_piece(duped_piece)

    begin
      duped_piece.perform_moves!(move_sequence)
    rescue InvalidMoveError
      false
    else
      true
    end
  end

  def perform_slide(x, y)
    return false if @board[x, y] || !move_diffs.include?([x, y])
    move_piece!(x, y)
  end

  def perform_jump(x, y)
    capture = [(x + self.x) / 2, (y + self.y) / 2]

    if @board[*capture] && move_diffs(:jump).include?([x, y])
      @board[*capture] = nil
      move_piece!(x, y)
    else
      false
    end
  end

  def move_diffs(type = :slide)
    @king ? moves = F_MOVES + B_MOVES : moves = F_MOVES
    op = color == :red ? :+ : :-

    moves = moves.map { |move| move.map { |coord| coord * 2} } if type == :jump
    moves.map { |move| [self.x.send(op, move[0]), self.y.send(op, move[1])] }
  end

  def move_piece!(x, y)
    @board[x, y], @board[self.x, self.y]= self, nil
    @coordinates = [x, y]
    true
  end

  def maybe_promote?
    @king = true if (@color == :red && self.x == 7) || (@color == :white && self.x == 0)
  end
end