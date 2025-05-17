# frozen_string_literal: true

require './lib/hangman'

puts 'Choose your language/Escolha seu idioma: (en or pt-BR)'
default_locale = gets.chomp

Hangman::Config.build(default_locale)
