# frozen_string_literal: true

require './lib/repositories/repo_file'
require './lib/repositories/topic'
require './lib/entities/topic'
require './lib/entities/keywordable'
require './lib/entities/displayable'
require './lib/entities/puppetable'
require './lib/ui/text_color'
require './lib/ui/emoji'
require './lib/hangman/config'
require './lib/hangman/game'

require 'awesome_print'
require 'factory_bot'
require 'pry'
require 'i18n'

RSpec.configure do |config|
  config.before :all do
    I18n.load_path << "#{__dir__}/../config/locales/en.yml"
    I18n.available_locales = [:en]
    I18n.default_locale = :en
  end
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
