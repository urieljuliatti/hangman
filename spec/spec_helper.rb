# frozen_string_literal: true

require './lib/repositories/repo_file'
require './lib/repositories/topic'
require './lib/entities/topic'
require './lib/entities/word'
require './lib/hangman/config'

require 'awesome_print'
require 'factory_bot'
require 'pry'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.before(:suite) do
    FactoryBot.find_definitions
  end
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
