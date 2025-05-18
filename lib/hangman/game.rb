# frozen_string_literal: true

module Hangman
  # @selected_topic_entity is an instance of TopicEntity
  class Game
    include Entities::Keywordable # handles the keyword
    include Entities::Displayable # builds the game output
    include Entities::Puppetable # builds the hangman body

    def initialize(selected_topic_entity)
      @selected_topic_entity = selected_topic_entity
      @mistakes = []
      @successes = []
    end

    def answer(letter)
      return if taken?(letter) || letter.empty?

      response = included?(letter)
      if response
        search_and_index(letter)
        @successes.push(letter)
      else
        @mistakes.push(letter)
      end
      response
    end

    def start
      display
      puts
      play_game
      puts end_game_message
    end

    def play_game
      until game_over?
        break if won?

        print I18n.t('game.start')
        letter = $stdin.gets.chomp.to_s
        puts
        puts answer_feedback answer(letter)
        puts
        display
      end
    end

    def game_over?
      @mistakes.length >= 7
    end

    def won?
      indexed_keyword.all? { |_k, v| !v.nil? }
    end

    attr_reader :mistakes, :selected_topic_entity, :successes
  end
end
