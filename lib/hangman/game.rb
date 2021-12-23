# frozen_string_literal: true

module Hangman
  class Game
    #include Entities::Word
    #include Entities::Orchestrate ou extends

    def initialize(selected_topic)
      @selected_topic = selected_topic
      @mistakes = []
      @successes = []
    end

    def mistakes
      @mistakes
    end

    def successes
      @successes
    end

    def selected_topic
      @selected_topic
    end

    # Move to Orchestrate
    def answer(letter)
      if selected_topic_splitted.include?(letter)
        @successes.push(letter)
      else
        @mistakes.push(letter)
      end
    end

    # busca e indexa
    def search(letter)

    end

    def indexed
      @indexed
    end


    # ex: word = "sala"
    # hash indexado depois da busca
    @indexed = { 0 => nil, 1 => "a", 2 => nil, 3 => "a" }

    def hangman
      errors = {
        1 => pole,
        2 => head,
        3 => body,
        4 => left_arm,
        5 => arms,
        6 => left_leg,
        7 => legs
      }
      @mistakes.length each {|index| puts errors[index] }
    end

    private

    def selected_topic_splitted
      @selected_topic.keyword.split('')
    end

    def pole
      ' ===| '
    end

    def head
      '    0  '
    end

    def body
      '    |  '
    end

    def left_arm
      '   /|  '
    end

    def arms
      '   /|\ '
    end

    def left_leg
      '   /   '
    end

    def legs
      '   / \ '
    end
  end
end
