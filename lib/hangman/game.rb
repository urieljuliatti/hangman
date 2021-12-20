# frozen_string_literal: true

module Hangman
  class Game

    include Entities::Word

    class << self
      def init; end
      
      def status
        []
      end
      
      def mistakes
        []
      end

      def successes
        []
      end
    end
  end
end
