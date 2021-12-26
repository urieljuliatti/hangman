# frozen_string_literal: true

module Entities
  # Responsável pelas questões visuais: cores e o que é disposto em tela
  module Displayable
    # TODO: Optar pela gem? https://github.com/fazibear/colorize
    # Exemplo de como as cores funcionam:
    # https://stackoverflow.com/questions/1489183/how-can-i-use-ruby-to-colorize-the-text-output-to-a-terminal

    def display
      puts selected_topic_status
      puts keyword_status
      puts successes_status
      puts mistakes_status
      puts hangman
    end

    def answer_feedback(response)
      response ? "\e[42m\e[39m\e[5m Right answer! \e[0m" : "\e[40m\e[41m\e[5m Wrong answer! \e[0m"
    end

    def selected_topic_status
      selected_topic_entity.display
    end

    def keyword_status
      "\e[40m\e [keyword]: #{indexed_keyword_display} \e[0m"
    end

    def successes_status
      "\e[42m\e[39m\e [successes]: #{successes.length} => [letters]: #{successes} \e[0m"
    end

    def mistakes_status
      "\e[41m\e[39m\e [mistakes]: #{mistakes.length} => [letters]: #{mistakes} \e[0m"
    end

    def end_game_message
      won? ? 'You won!' : 'You lose!'
    end

    private

    def indexed_keyword_display
      display = []
      indexed_keyword.each_value { |v| v.nil? ? display.push(' _ ') : display.push(" #{v} ") }
      display.join(' ')
    end
  end
end
