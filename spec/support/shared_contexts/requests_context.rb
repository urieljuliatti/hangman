# frozen_string_literal: true

RSpec.shared_context 'requests context' do
  before do
    require_relative '../../../lib/requests/auth'
  end
end
