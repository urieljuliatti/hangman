# frozen_string_literal: true
require 'i18n'
require 'pry'

I18n.load_path << Dir["#{File.expand_path('config/locales')}/*.yml"]
I18n.default_locale = ARGV.empty? ? :en : ARGV[0].to_sym

require './lib/hangman/config'
require './lib/entities/keywordable'
require './lib/ui/emoji'
require './lib/entities/displayable'
require './lib/entities/puppetable'
require './lib/hangman/game'
require './lib/repositories/topic'
require './lib/repositories/repo_file'
require './lib/entities/topic'
require './lib/ui/text_color'
