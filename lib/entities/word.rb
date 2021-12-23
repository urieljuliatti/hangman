# frozen_string_literal: true

module Entities
  module Word
=begin
    class << self
      def letters
        Repositories::Topic::KEYWORD.split('')
      end

      def include?(letter)
        letters.include?(letter)
      end
    end
=end
  end
end
