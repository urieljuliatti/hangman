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
require './lib/requests/auth'

require 'awesome_print'
require 'factory_bot'
require 'fuubar'
require 'pry'
require 'i18n'

# Load shared examples
Dir[File.join(__dir__, 'support/shared_examples/**/*.rb')].sort.each { |file| require file }

# Load shared contexts
Dir[File.join(__dir__, 'support/shared_contexts/**/*.rb')].sort.each { |file| require file }

RSpec.configure do |config|
  config.before :all do
    I18n.load_path << "#{__dir__}/../config/locales/en.yml"
    I18n.load_path << "#{__dir__}/../config/locales/pt-BR.yml"
    I18n.available_locales = %i[en pt-BR]
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

  config.fuubar_progress_bar_options = { format: ' %c/%C |%w>%i| %e ' }
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = 'spec/examples.txt'
  config.disable_monkey_patching!
  config.warnings = true

  config.order = :random
  Kernel.srand config.seed
end
