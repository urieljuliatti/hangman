# frozen_string_literal: true

require './lib/ui/emoji'

module Entities
  # Responsável pelas questões visuais: cores e o que é disposto em tela
  # Emojis: http://unicode.org/emoji/charts/full-emoji-list.html#1f469_1f3fb_200d_1f4bb
  module Displayable
    include UI::Emoji

    def display
      puts "\u{25AA}" * wider
      puts
      puts selected_topic_status
      puts
      puts keyword_status
      puts
      puts "\u{25AA}" * wider
      puts
      print successes_status, mistakes_status
      puts
      puts
      puts "\u{25AA}" * wider
      puts
      puts "\u{1F480} #{I18n.t('displayable.reaper')} \u{1F480}"
      puts hangman
      puts "\u{25AA}" * wider
      puts
    end

    def answer_feedback(response)
      response ? " #{emoji(0x1F7E2)} #{I18n.t('displayable.right_answer')}".color(:green) : "#{emoji(0x1F6A8)} #{I18n.t('displayable.wrong_answer')}".color(:red)
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

    def wider
      selected_topic_status.length > keyword_status.length ? selected_topic_status.length : keyword_status.length
    end

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
