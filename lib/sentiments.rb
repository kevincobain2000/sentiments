require "sentiments/version"
require 'json'
module Sentiments
  class Classifier
    MIN_TOKEN_LENGTH = 1
    MAX_TOKEN_LENGTH = 15
    PRIOR_SCORE = 0.33
    def initialize
      # @neg_words    = load_json('neg')
      # @pos_words    = load_json('pos')
      # @neu_words    = load_json('neu')
      @prefix_words = load_json('prefix')
      @ignore_words = load_json('ignore')

      @categories = ['pos', 'neg', 'neu']

      @dictionary = {}
      @doc_count = 0
      @token_count = 0
      @category_tok_count = {'pos' => 0, 'neg' => 0, 'neu' => 0}
      @category_doc_count = {'pos' => 0, 'neg' => 0, 'neu' => 0}

      @categories.each do |category|
        if (!set_dictionary(category))
          raise "Unable to Set Dictionaries"
        end #if
      end

    end #initialize

    def score(sentence)
      scores = {}
      @prefix_words.each do |pw|
        # Search if that prefix is in the sentence
        if sentence.index(pw)
          # Remove the white space after the negative prefix
          sentence.sub! pw+" ", pw
        end
      end
      tokens = tokenize(sentence)
      total_score = 0

      @categories.each do |category|
        scores[category] = 1
        tokens.each do |token|
          if (token.length > MIN_TOKEN_LENGTH && token.length < MAX_TOKEN_LENGTH && !(@ignore_words.include? token))

            # If Token is not in our dictionary, don't do anything
            if(@dictionary[token].nil?)
              break
            end #if

            if (@dictionary[token][category].nil?)
              count = 0
            else
              count = @dictionary[token][category]
            end # elseif
            scores[category] *= (count + 1)
          end #if
        end #tokens
        scores[category] = PRIOR_SCORE * scores[category]
      end #categories

      @categories.each do |category|
        total_score += scores[category]
      end #categories

      @categories.each do |category|
        scores[category] = scores[category]/total_score
      end #categories

      return scores
    end #score

    private

    def load_json(filename)
      path = 'sentiments/data/'
      path = File.dirname(__FILE__) + '/sentiments/data/'
      return JSON.parse(IO.read(path +filename +'.json'))
    end

    def set_dictionary(category)
      words = load_json(category)
      words.each do |word|
        @doc_count += 1
        @category_doc_count[category] += 1

        if (@dictionary[word].nil?)
          @dictionary[word] = {}
          @dictionary[word][category] = 1
        end
        @category_tok_count[category] += 1
        @token_count += 1
      end
      return true
    end #set_dictionary

    def tokenize(sentence)
      sentence = sentence.downcase
      return sentence.split()
    end #tokenize

  end #class
end #module

def sentiments
  return Sentiments::Classifier.new
end
