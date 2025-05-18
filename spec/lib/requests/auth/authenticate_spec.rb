# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Requests::Auth do
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
end
