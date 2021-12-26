# frozen_string_literal: true

module Entities
  Topic = Struct.new :subject, :keyword, :kind, :name, keyword_init: true do
    def display
      "[subject]: \e[1m#{subject}\e[0m and [kind]: \e[1m#{kind} \e[0m"
    end
  end
end
