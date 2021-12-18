# frozen_string_literal: true

require_relative 'hangman/base'
require_relative 'hangman/config'
require_relative 'hangman/game'
require_relative 'hangman/player'
require_relative './repositories/repo_file'
require_relative './repositories/topic'
require_relative './entities/topic'

# prepare the game / pickup random word
Config.prepare

# start the game
Config.greetings
