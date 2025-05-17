# frozen_string_literal: true

require './lib/ui/emoji'

module Entities
  # Responsável pelas questões visuais: cores e o que é disposto em tela
  # Emojis: http://unicode.org/emoji/charts/full-emoji-list.html#1f469_1f3fb_200d_1f4bb
  module Displayable
    include UI::Emoji

    def display
      display_header
      display_game_status
      display_footer
    end

    def answer_feedback(response)
      if response
        " #{emoji(0x1F7E2)} #{I18n.t('displayable.right_answer')}".color(:green)
      else
        "#{emoji(0x1F6A8)} #{I18n.t('displayable.wrong_answer')}".color(:red)
      end
    end

    def selected_topic_status
      selected_topic_entity.display
    end

    def keyword_status
      "[#{I18n.t('displayable.keyword')}]: #{indexed_keyword_display}".color(:cyan)
    end

    def successes_status
      format(
        '[%<label>s]: %<count>d => [%<letters_label>s]: %<letters>s',
        label: I18n.t('displayable.successes'),
        count: successes.length,
        letters_label: I18n.t('displayable.letters'),
        letters: successes
      ).color(:green)
    end

    def mistakes_status
      format(
        '[%<label>s]: %<count>d => [%<letters_label>s]: %<letters>s',
        label: I18n.t('displayable.mistakes'),
        count: mistakes.length,
        letters_label: I18n.t('displayable.letters'),
        letters: mistakes
      ).color(:red)
    end

    def end_game_message
      won? ? I18n.t('displayable.you_won') : I18n.t('displayable.you_lose')
    end

    private

    def display_header
      print_border
      puts selected_topic_status
      puts
      puts keyword_status
      puts
      print_border
      puts
    end

    def display_game_status
      print successes_status, mistakes_status
      puts
      puts
      print_border
      puts
      puts "#{emoji(0x1F480)} #{I18n.t('displayable.reaper')} #{emoji(0x1F480)}"
      puts hangman
    end

    def display_footer
      print_border
      puts
    end

    def print_border
      puts emoji(0x25AA).to_s * wider
    end

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
        display.insert(k - 1, ' ') if whitespaces[:whitespace_indexes].include?(k - 1) && !whitespaces.empty?
      end
      display.join(' ')
    end
  end
end
