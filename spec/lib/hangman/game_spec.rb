# frozen_string_literal: true

RSpec.describe Hangman::Game do
  subject(:game) { described_class.new(selected_topic) }
  subject(:answer) { game.answer(letter) }

  let(:letter) { 'c' }

  let(:selected_topic) { build(:topic) }

  describe '.mistakes' do

    subject(:mistakes) { game.mistakes }

    before do
      game.answer('f')
      game.answer('w')
    end

    it { expect(game.mistakes).to_not be_empty }
    it { expect(game.mistakes).to contain_exactly('f', 'w') }
    it { expect(game.mistakes).to match_array ['f', 'w'] }
    it { expect(game.mistakes.count).to eql 2 }
    it { is_expected.to contain_exactly('f', 'w') }
    it { is_expected.to match_array ['f', 'w'] }
  end

  describe '.successes' do

  end

  describe '.answer' do
    context 'when is mistaken' do
      let(:letter) { 'd' }

      before do
        answer
      end

      it { expect(game.mistakes).to_not be_empty }
      it { expect(game.mistakes).to contain_exactly('d') }
      it { expect(game.mistakes).to match_array ['d'] }
      it { is_expected.to contain_exactly('d') }
      it { is_expected.to match_array ['d'] }
    end

    context 'when is correct' do
      let(:letter) { 'c' }

      before do
        answer
      end

      it { expect(game.successes).to_not be_empty }
      it { expect(game.successes).to contain_exactly('c') }
      it { expect(game.successes).to match_array ['c'] }
      it { is_expected.to contain_exactly('c') }
      it { is_expected.to match_array ['c'] }
    end
  end
end
