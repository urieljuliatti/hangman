# frozen_string_literal: true

require_relative './repo_file'
require_relative '../entities/topic'

module Repositories
  # topic reposiory query class
  class Topic
    def initialize
      @topic_entity = Entities::Topic.new
    end

    def selected_topic
      @selected_topic ||= select_topic
    end

    def select_topic
      collection.each_key do |key|
        @topic_entity.subject = SUBJECT if key.eql?(SUBJECT)
        collection[key].each do |kw, value|
          next unless kw.eql?(KEYWORD)

          @topic_entity.keyword = KEYWORD
          @topic_entity.kind = value['kind']
          @topic_entity.name = value['name']
        end
      end
      @topic_entity
    end

    def collection
      @collection ||= RepoFile.all
    end

    class << self
      # expose collection to constants
      def collection
        RepoFile.all
      end
    end

    # Randomized value for each game
    RANDOM_SUBJECT_ID = (rand 0..collection.length - 1).freeze
    RANDOM_KEYWORD_ID = (rand 0..collection.values[RANDOM_SUBJECT_ID].length - 1).freeze
    KEYWORD = collection.values[RANDOM_SUBJECT_ID].keys[RANDOM_KEYWORD_ID].freeze
    SUBJECT = collection.keys[RANDOM_SUBJECT_ID].freeze
  end
end
