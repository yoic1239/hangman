# frozen_string_literal: true

require './lib/dictionary'

# Hangman game
class Game
  def initialize
    @secret_word = Dictionary.random
    @reveal_word = Array.new(@secret_word.length, '_')
    @chances = 7
    @incorrect_letter = []
  end

  def play
    loop do
      puts @reveal_word.join(' ')
      guess_each_round
      puts ''
      break if win? || lose?
    end
    puts result
  end

  def guess_each_round
    guess = make_guess
    if @secret_word.include?(guess)
      update_reveal_word(guess)
    else
      @incorrect_letter.push(guess)
      @chances -= 1
      puts "Incorrect guess. You have #{@chances} chances left."
    end
  end

  def make_guess
    loop do
      print 'Enter your guess: '
      guess = gets.chomp.downcase
      return guess if guess.length == 1 && !@incorrect_letter.include?(guess)

      puts 'Invalid guess. Please enter a letter that you haven\'t guessed before!'
    end
  end

  def update_reveal_word(guess)
    @secret_word.split('').each_with_index do |letter, index|
      @reveal_word[index] = letter if letter == guess
    end
  end

  def win?
    @secret_word == @reveal_word.join
  end

  def lose?
    @chances.zero?
  end

  def result
    if win?
      "Bingo! The secret word is #{@secret_word}."
    else
      "You lose, the man is hung. The secret word is #{@secret_word}"
    end
  end
end

game = Game.new
game.play
