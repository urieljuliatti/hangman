# frozen_string_literal: true

require_relative './repo_file'
require_relative '../entities/topic'

module Repositories
  # Responsible for creating the randomized topic
  class Topic
    def initialize(rspec_flag: false)
      @rspec_flag = rspec_flag
      @topic_entity = Entities::Topic.new
      rspec_flag ? build_cheetah : randomized
    end

    def selected_topic_entity
      @selected_topic_entity ||= rspec_flag ? build_cheetah : select_topic_entity
    end

    def select_topic_entity
      collection.each_key do |key|
        next unless key.eql?(randomized[:subject])

        set_subject
        set_keyword_and_attributes
      end
      @topic_entity
    end

    def randomized
      @randomized ||= random
    end

    attr_reader :rspec_flag

    def build_cheetah
      @topic_entity.subject = 'animals'
      @topic_entity.keyword = collection['animals'].keys.first
      @topic_entity.kind = collection['animals']['cheetah']['kind']
      @topic_entity.name = collection['animals']['cheetah']['name']
      @topic_entity
    end

    private

    def set_subject
      @topic_entity.subject = randomized[:subject]
    end

    def set_keyword_and_attributes
      collection[randomized[:subject]].each do |kw, value|
        next unless kw.eql?(randomized[:keyword])

        @topic_entity.keyword = randomized[:keyword]
        @topic_entity.kind = value['kind']
        @topic_entity.name = value['name']
      end
    end

    def collection
      RepoFile.all
    end

    def random
      @randomized = {}
      subject_id, keyword_id = select_random_ids
      @randomized = build_randomized_data(subject_id, keyword_id)
    end

    def select_random_ids
      subject_id = rand(0..collection.length - 1)
      keyword_id = rand(0..collection.values[subject_id].length - 1)
      [subject_id, keyword_id]
    end

    def build_randomized_data(subject_id, keyword_id)
      {
        random_subject_id: subject_id,
        random_keyword_id: keyword_id,
        keyword: collection.values[subject_id].keys[keyword_id],
        subject: collection.keys[subject_id]
      }
    end
  end
end
