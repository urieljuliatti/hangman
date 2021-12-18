# frozen_string_literal: true

class Base
  class << self
    def fetch(key)
      TOPICS.find { |topic| topic.include?(key) }
    end
  end
end
