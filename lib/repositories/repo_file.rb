# frozen_string_literal: true

require 'json'

module Repositories
  class RepoFile

    DEFAULT_FILE = 'topics.json'.freeze
    DEFAULT_FILE_PATH = './lib/files'.freeze

    def initialize(file)
      @filepath = "./lib/files/#{file}"
    end

    def topics
      @topics ||= JSON.parse(File.read(@filepath), symbolize_key: true)
    end

    def self.all
      filepath = "#{DEFAULT_FILE_PATH}/#{DEFAULT_FILE}"
      JSON.parse(File.read(filepath), symbolize_key: true)
    end

    attr_accessor :filepath
  end
end
