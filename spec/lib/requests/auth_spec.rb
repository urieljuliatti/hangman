# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Requests::Auth do # rubocop:disable Metrics/BlockLength
  include_context 'requests context'

  subject(:auth) { described_class.new }

  describe '#authenticate' do
    let(:discogs) { instance_double(Discogs::Wrapper) }

    before do
      allow(Discogs::Wrapper).to receive(:new).and_return(discogs)
    end

    it 'initializes discogs client with correct parameters' do
      expect(Discogs::Wrapper).to receive(:new).with('Hangman', user_token: ENV['USER_TOKEN'])
      auth.authenticate
    end

    it 'sets discogs instance variable' do
      auth.authenticate
      expect(auth.discogs).to eq(discogs)
    end
  end

  describe '#fetch_user_data' do # rubocop:disable Metrics/BlockLength
    let(:discogs) { instance_double(Discogs::Wrapper) }
    let(:user) { { 'username' => 'urieljuliatti' } }
    let(:wantlist) do
      {
        'wants' => [
          {
            'basic_information' => {
              'artists' => [{ 'id' => '123' }]
            }
          }
        ]
      }
    end

    before do
      allow(Discogs::Wrapper).to receive(:new).and_return(discogs)
      allow(discogs).to receive(:get_user).and_return(user)
      allow(discogs).to receive(:get_user_wantlist).and_return(wantlist)
      auth.authenticate
    end

    it 'fetches user data' do
      expect(discogs).to receive(:get_user).with('urieljuliatti')
      auth.fetch_user_data('urieljuliatti')
    end

    it 'fetches user wantlist' do
      expect(discogs).to receive(:get_user_wantlist).with('urieljuliatti')
      auth.fetch_user_data('urieljuliatti')
    end

    it 'sets user and list instance variables' do
      auth.fetch_user_data('urieljuliatti')
      expect(auth.user).to eq(user)
      expect(auth.list).to eq(wantlist)
    end
  end

  describe '#process_wantlist' do
    let(:discogs) { instance_double(Discogs::Wrapper) }
    let(:releases) do
      {
        'releases' => [
          { 'id' => '456' }
        ]
      }
    end
    let(:release_data) { { 'tracklist' => [{ 'title' => 'Track 1' }] } }

    before do
      allow(Discogs::Wrapper).to receive(:new).and_return(discogs)
      allow(discogs).to receive(:get_artists_releases).and_return(releases)
      allow(discogs).to receive(:get_release).and_return(release_data)
      auth.authenticate
      auth.instance_variable_set(
        :@list,
        { 'wants' => [{ 'basic_information' => { 'artists' => [{ 'id' => '123' }] } }] }
      )
    end

    it 'processes wantlist items' do
      expect(discogs).to receive(:get_artists_releases).with('123')
      expect(discogs).to receive(:get_release).with('456')
      auth.process_wantlist
    end
  end
end
