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
      if included?(letter)
        search_and_index(letter)
        @successes.push(letter)
        # verifica se venceu
      else
        @mistakes.push(letter)
        # verifica se perdeu
      end
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
      mistakes.length each {|index| puts errors[index] }
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
