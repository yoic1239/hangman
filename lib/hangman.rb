# frozen_string_literal: true

require './lib/dictionary'

# Hangman game
class Game
  CHANCES = 7
  def initialize
    @secret_word = Dictionary.random
  end
end
