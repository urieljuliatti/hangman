# frozen_string_literal: true

module Hangman
  class Config

  class << self
    def greetings
      puts 'Welcome to hangman!'
      puts 'Do you want to initialize the game? (Type y to begin)'
      if gets.chomp.to_s.upcase == 'y'
        Game.init
      else
        exit
      end
    end

    def prepare
      # pick up the topic + word
    end
    
  end
end
end