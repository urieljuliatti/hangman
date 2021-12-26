# frozen_string_literal: true

module Hangman
  # @selected_topic_entity is an instance of TopicEntity
  class Game
    # Fornece métodos para tratamento da interação com a keyword através da letra fornecida
    # Melhoria? Alguns métodos poderiam ser incluidos na Entity?
    include Entities::Keywordable
    #include Entities::Orchestrable # orquestra as interações do jogo
    include Entities::Displayable # monta o status do jogo

    def initialize(selected_topic_entity)
      @selected_topic_entity = selected_topic_entity
      @mistakes = []
      @successes = []
    end

    # TODO: Remove whitespaces
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

    # TODO: Entities::Keywordable
    def indexed_keyword_display
      display = []
      indexed_keyword.each_value { |v| v.nil? ? display.push(' _ ') : display.push(" #{v} ") }
      display.join(' ')
    end

    # TODO: Entities::Orchestrable
    def start
      puts ''
      display
      puts ''
      until game_over?
        break if won?

        print 'Type a letter: '
        letter = gets.chomp.to_s
        answer(letter)
        display
      end
      puts end_game_message
    end

    # TODO: Entities::Orchestrable
    def game_over?
      @mistakes.length >= 7
    end

    # TODO: Entities::Orchestrable
    def won?
      indexed_keyword.all? { |_k, v| !v.nil? }
    end

    # TODO: Entities::Hangman
    def hangman
      errors = {
        0 => pole,
        1 => head,
        2 => body,
        3 => arms,
        4 => legs
      }
      errors.each_with_index { |_item, index| puts errors[index] }
    end

    attr_reader :mistakes, :selected_topic_entity, :successes

    private

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
