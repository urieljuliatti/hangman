# frozen_string_literal: true

RSpec.shared_examples 'game mistakes' do
  describe '.mistakes' do
    subject(:mistakes) { game.mistakes }

    before do
      game.answer('f')
      game.answer('w')
    end

    it { expect(game.mistakes).to_not be_empty }
    it { expect(game.mistakes).to contain_exactly('f', 'w') }
    it { expect(game.mistakes).to match_array %w[f w] }
    it { expect(game.mistakes.count).to eql 2 }
    it { is_expected.to contain_exactly('f', 'w') }
    it { is_expected.to match_array %w[f w] }
  end
end
