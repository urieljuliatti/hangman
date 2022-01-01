# frozen_string_literal: true

require 'i18n'

module Hangman
  # Responsável por carregar as informações iniciais do jogo
  module Config
    I18n.load_path << Dir[File.expand_path('config/locales') + '/*.yml']
    I18n.default_locale = :'pt-BR'

    def self.build
      topic = Repositories::Topic.new
      game = Hangman::Game.new(topic.selected_topic_entity)
      game.start
    end
  end
end
