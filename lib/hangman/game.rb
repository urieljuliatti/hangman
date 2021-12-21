# frozen_string_literal: true

module Hangman
  class Game
    #include Entities::Word

    # Orchastrates the game
    # include Entities::Orchestrate

    @@mistakes = []
    @@successes = []

    def initialize
      setup
    end

    class << self
      def init
        p 'Prompt the game with the word'
      end

      def setup
        mistakes
        successes
      end

      def status
        []
      end

      def mistakes
        @@mistakes
      end

      def successes
        @@successes
      end
    end
  end
end
