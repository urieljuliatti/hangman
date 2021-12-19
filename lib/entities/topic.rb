# frozen_string_literal: true

module Entities
  Topic = Struct.new :subject, :keyword, :kind, :name, keyword_init: true do
    def display
      "[subject]: #{subject} and [kind]: #{kind}"
    end
  end
end
