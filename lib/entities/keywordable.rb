# frozen_string_literal: true

module Entities
  # Everything depends on @selected_topic_entity (TopicEntity) to work
  module Keywordable
    def included?(letter)
      selected_topic_entity_letters.include?(letter)
    end

    def taken?(letter)
      mistakes.include?(letter) || successes.include?(letter)
    end

    def selected_topic_entity_letters
      selected_topic_entity.keyword.split('')
    end

    def repeated_letters(letter)
      repeated = {}
      repeated[:ids] = selected_topic_entity_letters.each_index.select { |i| selected_topic_entity_letters[i].eql?(letter) }
      repeated[:letters] = repeated[:ids].map { |id| selected_topic_entity_letters.fetch(id) }
      repeated
    end

    def whitespace; end

    # TODO: Contemplar espaços na keyword. O "_" facilita na detecção! O método whitespace dará conta
    def build_indexed_keyword
      indexed_keyword = {}
      selected_topic_entity_letters.each_index do |index|
        indexed_keyword[index] = nil
      end
      indexed_keyword
    end

    def indexed_keyword
      @indexed_keyword ||= build_indexed_keyword
    end

    def search_and_index(letter)
      repeated_letters = repeated_letters(letter)
      letters = selected_topic_entity_letters - repeated_letters[:letters]

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
  end
end
