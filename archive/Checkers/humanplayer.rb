class HumanPlayer

  #from http://www.jimloy.com/checkers/numbered.gif
  MOVE_MAP = {
    "1" => [0,1],
    "2" => [0,3],
    "3" => [0,5],
    "4" => [0,7],
    "5" => [1,0],
    "6" => [1,2],
    "7" => [1,4],
    "8" => [1,6],
    "9" => [2,1],
    "10" => [2,3],
    "11" => [2,5],
    "12" => [2,7],
    "13" => [3,0],
    "14" => [3,2],
    "15" => [3,4],
    "16" => [3,6],
    "17" => [4,1],
    "18" => [4,3],
    "19" => [4,5],
    "20" => [4,7],
    "21" => [5,0],
    "22" => [5,2],
    "23" => [5,4],
    "24" => [5,6],
    "25" => [6,1],
    "26" => [6,3],
    "27" => [6,5],
    "28" => [6,7],
    "29" => [7,0],
    "30" => [7,2],
    "31" => [7,4],
    "32" => [7,6]
  }

  attr_reader :name, :color

  def initialize(name, color, board)
    @name = name
    @color = color
    @board = board
  end

  def turn
    begin
      piece, move_sequence = get_input
      raise InvalidMoveError if piece.color != self.color
      piece.perform_moves(move_sequence)
    rescue InvalidInputError => e
      puts "Error: #{e.message}"
      retry
    end
  end

  private
  def get_input
    check_input([get_piece, get_moves])
  end

  def get_piece
    puts "Enter numbered square of piece to move:"
    coords = MOVE_MAP[gets.chomp] until !coords.nil?
    piece = @board[*coords]
    piece
  end

  def get_moves
    puts "Enter move sequence:"
    move_sequence = gets.chomp.split(",").map{ |i| MOVE_MAP[i] }
    check_input(move_sequence)
  end

  def check_input(input)
    raise InvalidInputError if input.flatten.include?(nil)
    input
  end

end