# frozen_string_literal: true

require 'json'
require 'i18n'

module Repositories
  class RepoFile

    DEFAULT_FILE = 'topics.json'.freeze
    DEFAULT_FILE_PATH = "./lib/files/#{I18n.default_locale}".freeze

    def initialize(file)
      @filepath = "./lib/files/#{I18n.default_locale}/#{file}"
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
