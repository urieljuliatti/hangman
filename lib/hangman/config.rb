# frozen_string_literal: true

module Hangman
  # Responsável por carregar as informações iniciais do jogo
  # O topic escolhido, por exemplo
  module Config
    @@settings = {}
    class << self
      def setup(topic, game)
        @@settings[:topic] = topic
        @@settings[:game] = game
        @@settings
      end

      def settings
        @@settings
      end

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
