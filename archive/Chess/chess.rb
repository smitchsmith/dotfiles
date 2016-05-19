require_relative 'pieces.rb'
require_relative 'board.rb'

class Game
  attr_reader :board

  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new(:white, @board)
    @player2 = HumanPlayer.new(:black, @board)
  end

  def play
    loop do
      @board.render
      @player1.play_turn
      break if @board.checkmate(@player2.color)
      @board.render
      @player2.play_turn
      break if @board.checkmate(@player1.color)
    end
  end

end

class HumanPlayer

  FILES = {
    "a" => 0,
    "b" => 1,
    "c" => 2,
    "d" => 3,
    "e" => 4,
    "f" => 5,
    "g" => 6,
    "h" => 7
  }

  RANKS = {
    "1" => 7,
    "2" => 6,
    "3" => 5,
    "4" => 4,
    "5" => 3,
    "6" => 2,
    "7" => 1,
    "8" => 0
  }

  attr_accessor :color

  def initialize(color, board)
    @color = color
    @board = board
  end

  def play_turn
    begin
      puts "Enter your starting coordinates"
      start_coord = translate_coordinates(gets.chomp)

      tile = @board.position[start_coord[0]][start_coord[1]]
      if tile
        raise "You can't move your opponent's pieces!" if tile.color != color
      else
        raise "No piece here!"
      end

      puts "Enter your ending coordinates"
      end_coord = translate_coordinates(gets.chomp)
      @board.move(start_coord, end_coord)
    rescue => e
      puts e.message
      retry
    end
  end

  def translate_coordinates(str)
    x, y = str.split("")
    coords = [RANKS[y], FILES[x]]
    raise "Enter valid coordinates!" unless coords.all?
    coords
  end

end
