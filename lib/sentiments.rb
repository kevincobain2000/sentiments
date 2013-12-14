require "sentiments/version"
require 'json'
module Sentiments
  class Classifier
    MIN_TOKEN_LENGTH = 1
    MAX_TOKEN_LENGTH = 15
    def initialize
      @neg_words    = load_json('neg')
      @pos_words    = load_json('pos')
      @neu_words    = load_json('neu')
      @prefix_words = load_json('prefix')
      @ignore_words = load_json('ignore')

      @categories = ['pos', 'neg', 'neu']

      # TODO set dictionary
    end

    def score(sentence)
      scores = {}
      @prefix_words.each do |pw|
        # Search if that prefix is in the sentence
        if sentence.index(pw)
          # Remove the white space after the negative prefix
          sentence.sub! pw+" ", pw
        end
      end
      tokens = sentence.split()
      total_score = 0

      @categories.each do |category|
        scores[category] = 1
        tokens.each do |token|
          if (token.length > MIN_TOKEN_LENGTH && token.length < MAX_TOKEN_LENGTH && !(@ignore_words.include? token))
            puts
          end
        end
      end

      return scores
    end
    private
    def load_json(filename)
      return JSON.parse(IO.read('sentiments/data/' +filename +'.json'))
    end
  end
end

c = Sentiments::Classifier.new
puts c.score("nice good bad isn't it")



