# frozen_string_literal: true

require 'json'

module Repositories
  class RepoFile
    def initialize(file)
      @filepath = "./lib/files/#{file}"
    end

    def topics
      @topics ||= JSON.parse(File.read(@filepath), symbolize_key: true)
    end

    attr_accessor :filepath
  end
end
