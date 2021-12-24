# frozen_string_literal: true

module Hangman
  class Game
    #include Entities::Keyword # fornece métodos para tratamento das palavras, string, etc
    #include Entities::Orchestrate # orquestra o jogo num geral
    #include Entities::Screenplay # define o roteiro dos inputs
    #include Entities::StatusOutput # monta o status do jogo de acordo com a instância

    def initialize(selected_topic)
      @selected_topic = selected_topic
      @mistakes = []
      @successes = []
    end

    # Move to Orchestrate
    def answer(letter)
      if included?(letter)
        @successes.push(letter)
      else
        @mistakes.push(letter)
      end
    end

    def search_and_index(letter)
      return unless included?(letter)

      repeated_letters = repeated_letters(letter)
      letters = selected_topic_letters - repeated_letters[:letters]

      if repeated_letters.count > 1
        repeated_letters[:ids].each_index do |i|
          indexed_keyword[repeated_letters[:ids][i]] = repeated_letters[:letters][i]
        end
      else
        letters.each_index.select do |i|
          indexed_keyword[i] = letter
        end
      end
      indexed_keyword
    end

    def indexed_keyword
      @indexed_keyword ||= build_indexed_keyword
    end

    def hangman
      errors = {
        1 => pole,
        2 => head,
        3 => body,
        4 => left_arm,
        5 => arms,
        6 => left_leg,
        7 => legs
      }
      @mistakes.length each {|index| puts errors[index] }
    end

    attr_reader :mistakes, :selected_topic, :successes

    private

    def repeated_letters(letter)
      repeated = {}
      repeated[:ids] = selected_topic_letters.each_index.select { |i| selected_topic_letters[i].eql?(letter) }
      repeated[:letters] = repeated[:ids].map { |id| selected_topic_letters.fetch(id) }
      repeated
    end

    # keyword.included?
    def included?(letter)
      selected_topic_letters.include?(letter)
    end

    def build_indexed_keyword
      @indexed_keyword = {}
      selected_topic_letters.each_index do |index|
        @indexed_keyword[index] = nil
      end
      @indexed_keyword
    end

    def selected_topic_letters
      @selected_topic.keyword.split('')
    end

    def pole
      ' ===| '
    end

    def head
      '    0  '
    end

    def body
      '    |  '
    end

    def left_arm
      '   /|  '
    end

    def arms
      '   /|\ '
    end

    def left_leg
      '   /   '
    end

    def legs
      '   / \ '
    end
  end
end
