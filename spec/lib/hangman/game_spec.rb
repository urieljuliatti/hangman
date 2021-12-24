# frozen_string_literal: true

RSpec.describe Hangman::Game do
  subject(:game) { described_class.new(selected_topic) }

  let(:letter) { 'c' }
  # animals / cheetah
  let(:selected_topic) { build(:topic) }
  let(:indexed_hash) {
    {
      0 => nil,
      1 => nil,
      2 => 'e',
      3 => 'e',
      4 => 't',
      5 => nil,
      6 => 'h'
    }
  }

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

  describe '.answer' do
    subject(:answer) { game.answer(letter) }

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
      let(:letter) { 'e' }

      before do
        answer
      end

      it { expect(game.successes).to_not be_empty }
      it { expect(game.successes).to contain_exactly('e') }
      it { expect(game.successes).to match_array ['e'] }
      it { is_expected.to contain_exactly('e') }
      it { is_expected.to match_array ['e'] }
    end
  end

  describe '.search_and_index' do
    context 'when indexes a single letter' do
      subject(:search_and_index) { game.search_and_index('a') }

      it { is_expected.to_not be_empty }
      it { is_expected.to_not be_nil }
      it {
        is_expected.to include(
          0 => nil,
          1 => nil,
          2 => nil,
          3 => nil,
          4 => nil,
          5 => 'a',
          6 => nil
        )
      }
    end

    context 'when indexes a repeated letter' do
      subject(:seasearch_and_indexrch) { game.search_and_index('e') }

      it { is_expected.to_not be_empty }
      it { is_expected.to_not be_nil }
      it {
          is_expected.to include(
          0 => nil,
          1 => nil,
          2 => 'e',
          3 => 'e',
          4 => nil,
          5 => nil,
          6 => nil
        )
      }
    end

    context 'when indexes with multiple letters' do
      subject(:seasearch_and_indexrch) { game.search_and_index('e') }

      before do
        game.search_and_index('e')
        game.search_and_index('t')
        game.search_and_index('h')
      end

      it { is_expected.to_not be_empty }
      it { is_expected.to_not be_nil }
      it {
        is_expected.to include(
          0 => nil,
          1 => 'h',
          2 => 'e',
          3 => 'e',
          4 => 't',
          5 => nil,
          6 => 'h'
        )
      }
    end
  end
end
