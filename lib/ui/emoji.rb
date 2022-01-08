# frozen_string_literal: true

module UI
  # Módulo responsável pelos emojis
  # Lista de emojis
  # UNICODE: http://unicode.org/emoji/charts/full-emoji-list.html#1f469_1f3fb_200d_1f4bb
  # Outros: https://www.quackit.com/character_sets/emoji/emoji_v3.0/unicode_emoji_v3.0_characters_all.cfm
  module Emoji
    def emoji(code)
      code.chr('UTF-8')
    end
  end
end
