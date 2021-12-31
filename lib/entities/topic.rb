# frozen_string_literal: true

module Entities
  Topic = Struct.new :subject, :keyword, :kind, :name, keyword_init: true do
    def display
      "[#{I18n.t('topic.subject')}]: \e[1m#{subject}\e[0m and [#{I18n.t('topic.kind')}]: \e[1m#{kind} \e[0m"
    end
  end
end
