# frozen_string_literal: true

module Hangman
  class Config

    #https://www.rubydoc.info/gems/rubocop/RuboCop/Cop/Style/ClassVars
    @@settings = {}

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

      def settings(topic)
        @@settings = {topic: topic}
      end
    end
  end
end
