# Load dictionary for hangman game
module Dictionary
  @@dict = File.readlines('google-10000-english-no-swears.txt').map!(&:chomp)

  def self.filter_by_length(min_length, max_length)
    @@dict.select { |word| word.length.between?(min_length, max_length) }
  end

  def self.random(dict = filter_by_length(5, 12))
    dict[rand(dict.length)]
  end
end
