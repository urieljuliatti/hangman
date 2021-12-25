# frozen_string_literal: true

module Hangman
  # @selected_topic_entity is an instance of TopicEntity
  class Game
    # Fornece métodos para tratamento da interação com a keyword através da letra fornecida
    # Melhoria? Poderia ser incluido na Entity?
    include Entities::Keywordable
    #include Entities::Orchestrable # orquestra as interações do jogo
    #include Entities::Screenplayble # define o roteiro dos inputs
    #include Entities::Displayable # monta o status do jogo

    def initialize(selected_topic_entity)
      @selected_topic_entity = selected_topic_entity
      @mistakes = []
      @successes = []
    end

    # TODO: Palavras com espaço
    def answer(letter)
      return if taken?(letter)

      if included?(letter)
        search_and_index(letter)
        @successes.push(letter)
      else
        @mistakes.push(letter)
      end
    end

    def game_over?
      @mistakes.length == 7
    end

    def won?
      indexed_keyword.all? { |_k, v| !v.nil? }
    end

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
