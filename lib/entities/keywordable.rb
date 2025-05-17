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
      repeated[:ids] = selected_topic_entity_letters.each_index.select do |i|
        selected_topic_entity_letters[i].eql?(letter)
      end
      repeated[:letters] = repeated[:ids].map { |id| selected_topic_entity_letters.fetch(id) }
      repeated
    end

    def whitespaces
      spaces = {}
      spaces[:whitespace_indexes] = selected_topic_entity_letters.each_index.select do |w|
        selected_topic_entity_letters[w].eql?('_')
      end
      spaces
    end

    def build_indexed_keyword
      indexed_keyword = {}
      selected_topic_entity_letters.each_with_index do |letter, index|
        indexed_keyword[index] = nil unless letter.eql?('_')
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
        index_repeated_letters(repeated_letters)
      else
        index_single_letter(letters, letter)
      end
      indexed_keyword
    end

    private

    def index_repeated_letters(repeated_letters)
      repeated_letters[:ids].each_index do |i|
        indexed_keyword[repeated_letters[:ids][i]] = repeated_letters[:letters][i]
      end
    end

    def index_single_letter(letters, letter)
      letters.each_index.select do |i|
        indexed_keyword[i] = letter
      end
    end
  end
end
