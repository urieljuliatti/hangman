# frozen_string_literal: true

module Repositories
  # topic class
  class Topic

    class << self
      def where(clauses)
        new(clauses: clauses)
      end
    end

    def initialize(clauses: {})
      @clauses = clauses
      @rows = []
    end
  end
end
