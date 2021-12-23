# frozen_string_literal: true

require_relative './repo_file'
require_relative '../entities/topic'

module Repositories
  # topic reposiory query class
  class Topic
    def initialize
      @topic_entity = Entities::Topic.new
      randomized
    end

    # TODO: uma forma dde fazer com métodos de classe
    def selected_topic
      @selected_topic ||= select_topic
    end

    def select_topic
      collection.each_key do |key|
        @topic_entity.subject = randomized[:subject] if key.eql?(randomized[:subject])
        collection[key].each do |kw, value|
          next unless kw.eql?(randomized[:keyword])

          @topic_entity.keyword = randomized[:keyword]
          @topic_entity.kind = value['kind']
          @topic_entity.name = value['name']
        end
      end
      @topic_entity
    end

    def collection
      @collection ||= RepoFile.all
    end

    def randomized
      @randomized ||= random
    end


    private

    def random
      @randomized = {}
      random_subject_id = (rand 0..collection.length - 1)
      random_keyword_id = (rand 0..collection.values[random_subject_id].length - 1)
      keyword = collection.values[random_subject_id].keys[random_keyword_id]
      subject = collection.keys[random_subject_id]
      @randomized = {
        random_subject_id: random_subject_id,
        random_keyword_id: random_keyword_id,
        keyword: keyword,
        subject: subject
      }
    end
  end
end
