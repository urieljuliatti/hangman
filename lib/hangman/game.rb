# frozen_string_literal: true

module Hangman
  class Game
    class << self
      def init; end

      def mistakes
        []
      end

      def successes
        []
      end
    end
  end
end
