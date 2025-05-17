# frozen_string_literal: true

RSpec.shared_examples 'game successes' do
  describe '.successes' do
    subject(:successes) { game.successes }

    before do
      game.answer('e')
      game.answer('t')
      game.answer('h')
    end

    it { expect(game.successes).to_not be_empty }
    it { expect(game.successes).to contain_exactly('e', 't', 'h') }
    it { expect(game.successes).to match_array %w[e t h] }
    it { expect(game.successes.count).to eql 3 }
    it { is_expected.to contain_exactly('e', 't', 'h') }
    it { is_expected.to match_array %w[e t h] }
  end
end
