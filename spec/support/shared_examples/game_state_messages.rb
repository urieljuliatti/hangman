# frozen_string_literal: true

RSpec.shared_examples 'game state messages' do
  it_behaves_like 'successes status'
  it_behaves_like 'mistakes status'
  it_behaves_like 'end game messages'
end
