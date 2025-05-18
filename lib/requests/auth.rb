# frozen_string_literal: true

require 'discogs'

module Requests
  # Handles authentication with the Discogs API
  class Auth
    attr_accessor :discogs, :artist, :user, :list

    def authenticate
      @discogs = Discogs::Wrapper.new('Hangman', user_token: ENV['USER_TOKEN'])
    end

    def user_actions
      fetch_user_data
      process_wantlist
    end

    private

    def fetch_user_data
      @user = @discogs.get_user('urieljuliatti')
      @list = @discogs.get_user_wantlist('urieljuliatti')
    end

    def process_wantlist
      @list['wants'].each do |want|
        process_release(want)
      end
    end

    def process_release(want)
      puts "A info é: #{want['basic_information']}"
      releases = fetch_artist_releases(want)
      process_releases(releases)
    end

    def fetch_artist_releases(want)
      artist_id = want['basic_information']['artists'][0]['id']
      @discogs.get_artists_releases(artist_id)
    end

    def process_releases(releases)
      releases['releases'].each do |release|
        release_data = @discogs.get_release(release['id'].to_s)
      end
    end
  end
end
