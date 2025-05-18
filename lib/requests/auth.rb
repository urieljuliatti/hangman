# frozen_string_literal: true

require 'discogs'

module Requests
  # Handles authentication and data fetching from the Discogs API
  class Auth
    attr_reader :discogs, :user, :list

    def initialize
      @discogs = nil
      @user = nil
      @list = nil
    end

    def authenticate
      @discogs = Discogs::Wrapper.new('Hangman', user_token: ENV['USER_TOKEN'])
    end

    def fetch_user_data(username)
      @user = @discogs.get_user(username)
      @list = @discogs.get_user_wantlist(username)
    end

    def process_wantlist
      return if @list.nil? || @list['wants'].empty?

      @list['wants'].each do |want|
        process_release(want)
      end
    end

    private

    def process_release(want)
      basic_info = want['basic_information']
      puts "Release info: #{basic_info}"

      releases = fetch_artist_releases(basic_info)
      process_releases(releases)
    end

    def fetch_artist_releases(basic_info)
      artist_id = basic_info['artists'][0]['id']
      @discogs.get_artists_releases(artist_id)
    end

    def process_releases(releases)
      return if releases.nil? || releases['releases'].nil?

      releases['releases'].each do |release|
        release_data = @discogs.get_release(release['id'])
        display_track_info(release_data)
      end
    end

    def display_track_info(release_data)
      return if release_data.nil? || release_data['tracklist'].nil?

      release_data['tracklist'].each_with_index do |r, i|
        puts r
        puts "Track: #{release_data['tracklist'][i]['title']}"
      end
    end
  end
end
