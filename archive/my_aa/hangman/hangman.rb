class Board
  attr_reader :answer

  def initialize
    @answer = ComputerPlayer.new.pick_word.split("")
    @board = generate
  end

  def generate
    @answer.map{"_"}
  end

  def display
    puts @board.join(" ")
  end

  def mark_letter(users_letter)
    @answer.each_index do |i|
      @board[i] = users_letter if users_letter == @answer[i]
    end
  end

  def win?
    !@board.include?("_")
  end
end

class Hangman
  def initialize
    @turns = 8
    @board = Board.new
  end

  def play
    puts "Welcome to Hangman!"
    @board.display
    loop do
      turn
      @board.display
      return "You win!" if @board.win?
      return "Game Over" if @turns == 0
    end

  end

  def turn
    puts "Choose a letter."
    users_letter = gets.chomp

    if @board.answer.include?(users_letter)
      @board.mark_letter(users_letter)
    else
      @turns -= 1
      puts "Sorry, wrong guess."
      puts "You have #{@turns} turns left"
    end
  end

end

class ComputerPlayer
  def pick_word
    File.readlines("dictionary.txt").sample.chomp
  end
end