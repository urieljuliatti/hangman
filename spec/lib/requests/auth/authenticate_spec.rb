# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Requests::Auth do
  include_context 'requests context'

  subject(:auth) { described_class.new }

  describe '#authenticate' do
    let(:discogs) { instance_double(Discogs::Wrapper) }
    let(:request_data) do
      {
        request_token: 'request_token_123',
        authorize_url: 'http://discogs.com/authorize'
      }
    end

    before do
      allow(Discogs::Wrapper).to receive(:new).and_return(discogs)
      allow(discogs).to receive(:get_request_token).and_return(request_data)
      auth.session = {}
    end

    it 'stores request token in session' do
      auth.authenticate
      expect(auth.session[:request_token]).to eq('request_token_123')
    end
  end
end
