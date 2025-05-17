# frozen_string_literal: true

module Entities
  Topic = Struct.new :subject, :keyword, :kind, :name, keyword_init: true do
    def display
      "[#{I18n.t('topic.subject')}]: #{subject} " \
      "#{I18n.t('grammar.and')} " \
      "[#{I18n.t('topic.kind')}]: #{kind}".color(:yellow)
    end
  end
end
