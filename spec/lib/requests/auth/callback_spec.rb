# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Requests::Auth do
  include_context 'requests context'

  subject(:auth) { described_class.new }

  describe '#callback' do
    let(:discogs) { instance_double(Discogs::Wrapper) }
    let(:access_token) { 'access_token_123' }

    before do
      allow(Discogs::Wrapper).to receive(:new).and_return(discogs)
      allow(discogs).to receive(:authenticate).and_return(access_token)
      auth.session = { request_token: 'request_token_123' }
    end

    it 'clears request token from session' do
      auth.callback
      expect(auth.session[:request_token]).to be_nil
    end

    it 'stores access token in session' do
      auth.callback
      expect(auth.session[:access_token]).to eq('access_token_123')
    end
  end
end
