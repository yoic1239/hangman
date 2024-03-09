# frozen_string_literal: true

require './lib/dictionary'
require 'yaml'

# Hangman game
class Game
  def initialize
    @load_game = false
    ask_whether_load_saved_game if File.exist? 'save/saved_game.yml'
    if @load_game
      load_saved_game
    else
      start_new_game
    end
  end

  def play
    puts 'Game Start!'
    loop do
      puts @reveal_word.join(' ')
      guess_each_round
      puts ''
      break if win? || lose?
      return if @saved
    end
    puts result
    File.delete('save/saved_game.yml') if @load_game
  end

  protected

  def guess_each_round
    guess = make_guess
    save_game && return if guess == 'save'

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
      print 'Enter your guess (or type \'save\' to save the game): '
      guess = gets.chomp.downcase
      return guess if guess.length == 1 && !@incorrect_letter.include?(guess) || guess == 'save'

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

  def save_game
    Dir.mkdir('save') unless Dir.exist?('save')
    filename = 'save/saved_game.yml'
    File.open(filename, 'w') do |file|
      file.puts to_yaml
    end
    @saved = true
  end

  def to_yaml
    YAML.dump({
                secret_word: @secret_word,
                reveal_word: @reveal_word,
                chances: @chances,
                incorrect_letter: @incorrect_letter
              })
  end

  def load_saved_game
    saved_game = YAML.load_file('save/saved_game.yml')
    @secret_word = saved_game[:secret_word]
    @reveal_word = saved_game[:reveal_word]
    @chances = saved_game[:chances]
    @incorrect_letter = saved_game[:incorrect_letter]
  end

  def ask_whether_load_saved_game
    loop do
      puts 'You have a saved game. Do you want to continue to play? (Y/N)'
      load_game = gets.chomp.downcase
      @load_game = true if load_game == 'y'
      break if %w[y n].include?(load_game)
    end
  end

  def start_new_game
    @secret_word = Dictionary.random
    @reveal_word = Array.new(@secret_word.length, '_')
    @chances = 7
    @incorrect_letter = []
    @saved = false
  end
end

game = Game.new
game.play
