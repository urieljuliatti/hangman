# frozen_string_literal: true

RSpec.shared_examples 'game state' do
  describe '.won?' do
    subject { game.game_over? }

    before do
      game.answer('w')
      game.answer('f')
      game.answer('g')
      game.answer('j')
      game.answer('m')
      game.answer('n')
      game.answer('v')
    end

    it { is_expected.to be_truthy }
  end

  describe '.game_over?' do
    subject { game.won? }

    before do
      game.answer('e')
      game.answer('h')
      game.answer('c')
      game.answer('a')
      game.answer('t')
    end

    it { is_expected.to be_truthy }
  end
end
