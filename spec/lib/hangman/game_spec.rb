# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Hangman::Game do
  subject(:game) { described_class.new(selected_topic_entity) }

  let(:letter) { 'c' }
  # animals / cheetah
  let(:selected_topic_entity) { build(:topic_entity) }

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

    context 'when the letter is already taken' do
      before do
        game.answer('c')
      end
      it { is_expected.to be_nil }
    end

    context 'when is mistaken' do
      let(:letter) { 'd' }

      before do
        answer
      end

      it { expect(game.mistakes).to_not be_empty }
      it { expect(game.mistakes).to contain_exactly('d') }
      it { expect(game.mistakes).to match_array ['d'] }
      it { is_expected.to be_falsey}
    end

    context 'when is correct' do
      let(:letter) { 'e' }

      before do
        answer
      end

      it { expect(game.successes).to_not be_empty }
      it { expect(game.successes).to contain_exactly('e') }
      it { expect(game.successes).to match_array ['e'] }
      it { is_expected.to be_truthy }
    end

    context 'when the word has whitespaces' do
      let(:selected_topic_entity) { build(:topic_entity, :with_whitespace) }

      let(:letter) { 'n' }

      before do
        answer
        game.answer('e')
        game.answer('w')
        game.answer('y')
        game.answer('o')
        game.answer('r')
        game.answer('k')
      end

      it { expect(game.successes).to_not be_empty }
      it { expect(game.successes).to contain_exactly('n', 'e', 'w', 'y', 'o', 'r', 'k') }
      it { expect(game.successes).to match_array %w[n e w y o r k] }
      it { is_expected.to be_truthy }
      it { expect(game.won?).to be_truthy }
    end
  end

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
