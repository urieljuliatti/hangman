# frozen_string_literal: true

module Hangman
  class Config

    def initialize(topic)
      @topic = topic
      @settings = {}
    end

    def settings
      @settings = {topic: @topic}
    end

    class << self
      @settings = {}

      def greetings
        puts 'Welcome to hangman!'
        puts 'Do you want to initialize the game? (Type y to begin)'
        if gets.chomp.to_s.upcase == 'y'
          Game.init
        else
          exit
        end
      end
    end
  end
end
