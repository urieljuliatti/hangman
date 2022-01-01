# frozen_string_literal: true

module Entities
  # Responsável pelas questões visuais: cores e o que é disposto em tela
  module Displayable
    def display
      puts selected_topic_status
      puts keyword_status
      puts successes_status
      puts mistakes_status
      puts hangman
    end

    def answer_feedback(response)
      response ? "\e[42m\e[39m\e[5m #{I18n.t('displayable.right_answer')} \e[0m" : "\e[40m\e[41m\e[5m #{I18n.t('displayable.wrong_answer')} \e[0m"
    end

    def selected_topic_status
      selected_topic_entity.display
    end

    def keyword_status
      "[#{I18n.t('displayable.keyword')}]: #{indexed_keyword_display}".color(:cyan)
    end

    def successes_status
      "[#{I18n.t('displayable.successes')}]: #{successes.length} => [#{I18n.t('displayable.letters')}]: #{successes}".color(:green)
    end

    def mistakes_status
      "[#{I18n.t('displayable.mistakes')}]: #{mistakes.length} => [#{I18n.t('displayable.letters')}]: #{mistakes}".color(:red)
    end

    def end_game_message
      won? ? I18n.t('displayable.you_won') : I18n.t('displayable.you_lose')
    end

    private

    def indexed_keyword_display
      display = []
      indexed_keyword.each do |k, v|
        if v.nil?
          display.push(' _ ')
        else
          display.push(" #{v} ")
        end
        display.insert((k - 1), ' ') if whitespaces[:whitespace_indexes].include?(k - 1) && !whitespaces.empty?
      end
      display.join(' ')
    end
  end
end
