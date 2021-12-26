# frozen_string_literal: true

require_relative './repo_file'
require_relative '../entities/topic'

module Repositories
  # Responsável por criar o tópico randomizado
  class Topic
    def initialize(rspec_flag: false)
      @rspec_flag = rspec_flag
      @topic_entity = Entities::Topic.new
      rspec_flag ? build_cheetah : randomized
    end

    def selected_topic_entity
      @selected_topic_entity ||= rspec_flag ? build_cheetah : select_topic_entity
    end

    # TODO: mover para um módulo
    def select_topic_entity
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
    
    def collection
      RepoFile.all
    end

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
