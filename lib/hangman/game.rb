# frozen_string_literal: true

module Hangman
  # @selected_topic_entity is an instance of TopicEntity
  class Game
    include Entities::Keywordable # fornece métodos para tratamento das palavras, string, etc
    #include Entities::Orchestrable # orquestra o jogo num geral
    #include Entities::Screenplayble # define o roteiro dos inputs
    #include Entities::Displayable # monta o status do jogo de acordo com a instância, pode ser feito na ENTITY
    
    def initialize(selected_topic_entity)
      @selected_topic_entity = selected_topic_entity
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
