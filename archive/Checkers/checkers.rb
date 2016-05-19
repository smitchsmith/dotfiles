# encoding: UTF-8

require_relative "board"
require_relative "pieces"
require_relative "humanplayer"

class Game

  #for debugging.. not actually used anywhere
  attr_accessor :board, :player1, :player2, :turn

  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new("Donny", :red, @board)
    @player2 = HumanPlayer.new("Larry", :white, @board)
    @turn = :red
  end

  def play
    puts "Begin! #{@turn.to_s.capitalize} moves first."

    until @turn.over?
      take_turn(@turn)
    end

    puts "#{winner.name} won!"
  end

  def take_turn(color)
    @board.render
    player = color == :red ? @player1 : @player2
    player.turn
    @turn = @turn == :red ? :white : :red
  end

  def winner
    @board.winner_color == @player1.color ? @player1 : @player2
  end
end
