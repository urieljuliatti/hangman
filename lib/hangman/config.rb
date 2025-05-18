# frozen_string_literal: true

module Hangman
  # Responsible for loading the initial game information
  module Config
    def self.build(default_locale)
      I18n.default_locale = default_locale
      topic = Repositories::Topic.new
      game = Hangman::Game.new(topic.selected_topic_entity)
      game.start
    end
  end
end
