class Board

  attr_accessor :position

  def initialize(position = nil)
    @position = position
    @position ||= build_board
  end

  def build_board
    board = Array.new(8) { Array.new(8){ nil } }

    board[0] = build_home_row(0, :black)
    board[1] = build_pawn_row(1, :black)
    board[7] = build_home_row(7, :white)
    board[6] = build_pawn_row(6, :white)

    board
  end

  def build_home_row(row, color)
    # returns an array representing a row on the board
    home_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    home_row.map.with_index do |piece, i|
      piece.new([row,i], self, color)
    end
  end

  def build_pawn_row(row, color)
    (0..7).to_a.map { |i| Pawn.new([row,i], self, color) }
  end

  def dup
    finished_board = Board.new(Array.new(8) { Array.new(8){ nil } })

    duped_pieces.each do |piece|
      x, y = piece.coordinates
      finished_board.position[x][y] = piece
      piece.board = finished_board
    end

    finished_board
  end

  def duped_pieces
    duped_pieces = position.flatten
    duped_pieces.delete(nil)
    duped_pieces.map { |tile| tile.dup }
  end

  def render
    render = position.map do |row|
      row.map do |tile|
        if tile.is_a?(Piece)
          case tile
          when Rook
            "R"
          when Knight
            "N"
          when Bishop
            "B"
          when Queen
            "Q"
          when King
            "K"
          when Pawn
            "P"
          end
        else
          "_"
        end
      end.join(" ")
    end.join("\n")
    puts render
  end

  def in_check?(color)
    king_location = find_king(color)
    opponent_moves = all_opponent_moves(color)
    opponent_moves.include?(king_location)
  end

  def checkmate(color)
    return false unless in_check?(color)
    all_moves(color).empty?
  end

  def [](args)
    @position[args[0]][args[1]]
  end

  def []=(args, obj)
    @position[args[0]][args[1]] = obj
  end

  def move(start, endpoint)
    piece = self[start]

    raise "No piece here" if piece.nil?
    raise "Illegal Move" unless piece.valid_moves.include?(endpoint)

    self[start] = nil
    self[endpoint] = piece
    piece.coordinates = endpoint
  end

  def move!(start, endpoint)
    piece = self[start]
    self[start] = nil
    self[endpoint] = piece
    piece.coordinates = endpoint
  end

  def find_king(color)
    @position.flatten.each do |tile|
      if tile.is_a?(King) && tile.color == color
        return tile.coordinates
      end
    end
  end

  def all_opponent_moves(color)
    all_moves = []
    @position.flatten.each do |tile|
      next if tile.nil? || (tile.color == color)
      all_moves += tile.moves
    end

    all_moves
  end

  def all_moves(color)
    all_moves = []
    @position.flatten.each do |tile|
      next if tile.nil? || tile.color != color
      all_moves += tile.valid_moves
    end

    all_moves
  end

end