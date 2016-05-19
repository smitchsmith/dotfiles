# encoding: UTF-8
class Board
  def initialize(make_pieces = true)
    @board = build_board(make_pieces)
  end

  def [](x, y)
    @board[x][y]
  end

  def []=(x,y,obj)
    @board[x][y] = obj
  end

  def over?
    pieces.all? { |piece| pieces[0].color == piece.color }
  end

  def winner_color
    pieces[0].color if over?
  end

  def render
    grid = @board.map do |x|
      x.map do |y|
        if y
          y.to_utf8
        else
          "_"
        end
      end.join(" ")
    end.join("\n")
    puts grid
  end

  def add_piece(piece)
    piece.board = self
    self[piece.x, piece.y] = piece
    self
  end

  def dup
    duped_board = Board.new(false)
    pieces.each {|piece| duped_board.add_piece(piece.dup)}
    duped_board
  end

  private

  def build_board(make_pieces)
    board = Array.new(8){ Array.new(8) { nil } }

    if make_pieces
      [(0..2).to_a, (5..7).to_a].each do |rows|
        rows.each do |x|
          color = x > 2 ? :white : :red
          cols = x.odd? ? (0..7).select(&:even?) : (0..7).select(&:odd?)
          cols.each { |y| board[x][y] = Piece.new(color, self, x, y) }
        end
      end
    end

    board
  end

  def pieces
    @board.flatten.compact
  end
end