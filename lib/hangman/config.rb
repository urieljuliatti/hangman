# frozen_string_literal: true

module Hangman
  # Responsável por carregar as informações iniciais do jogo
  module Config
    def self.build
      topic = Repositories::Topic.new
      game = Hangman::Game.new(topic.selected_topic_entity)
      game.start
    end
  end
end
