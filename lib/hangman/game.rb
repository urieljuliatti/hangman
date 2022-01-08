# frozen_string_literal: true

module Hangman
  # @selected_topic_entity is an instance of TopicEntity
  class Game
    include Entities::Keywordable # trata a keyword
    include Entities::Displayable # monta o output do jogo
    include Entities::Puppetable # monta o status do hangman

    def initialize(selected_topic_entity)
      @selected_topic_entity = selected_topic_entity
      @mistakes = []
      @successes = []
    end

    def answer(letter)
      return if taken?(letter)

      if included?(letter)
        puts answer_feedback(true)
        search_and_index(letter)
        @successes.push(letter)
      else
        puts answer_feedback(false)
        @mistakes.push(letter)
      end
    end

    def start
      display
      puts
      until game_over?
        break if won?

        print I18n.t('game.start')
        letter = $stdin.gets.chomp.to_s
        answer(letter)
        display
      end
      puts end_game_message
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
