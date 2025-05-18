# frozen_string_literal: true

require 'discogs'

module Requests
  # Handles authentication with the Discogs API
  class Auth
    def self.authenticate
      @@discogs = Discogs::Wrapper.new('Hangman', user_token: ENV['USER_TOKEN'])
      artist = @@discogs.get_artist('329937')
      p artist.name
      p @@discogs.inspect
      p ENV['USER_TOKEN']
    end

    def self.another_action
      @@discogs = Discogs::Wrapper.new('Test OAuth', access_token: session[:access_token])
    end
  end
end
