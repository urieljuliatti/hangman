# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Entities::Keywordable do
  let(:game) { Hangman::Game.new(selected_topic) { include Entities::Keywordable } }
  # animals / cheetah
  let(:selected_topic) { build(:topic) }
  let(:letter) { 'c' }

  describe '.included?' do
    context 'when is true' do
      subject { game.included?(letter) }

      it { is_expected.to be_truthy }
    end
    context 'when is false' do
      subject { game.included?('r') }

      it { is_expected.to be_falsy }
    end
  end

  describe '.taken?' do
    context 'when letter have been already taken' do
      subject { game.taken?('e') }

      before do
        game.answer('e')
      end

      it { is_expected.to be_truthy }
    end
  end

  describe '.selected_topic_letters' do
    subject { game.selected_topic_letters }

    it { is_expected.to_not be_empty }
    it { is_expected.to match_array %w[c h e e t a h] }
    it { is_expected.to contain_exactly('c', 'h', 'e', 'e', 't', 'a', 'h') }
  end

  describe '.repeated_letters' do
    context 'when a letter is repeated' do
      subject { game.repeated_letters('e') }

      it { is_expected.to_not be_empty }
      it { is_expected.to include(ids: [2, 3], letters: %w[e e]) }
    end
  end

  describe '.build_indexed_keyword' do
    subject { game.build_indexed_keyword }

    it { is_expected.to_not be_empty }
    it {
      is_expected.to include(0 => nil,
                             1 => nil,
                             2 => nil,
                             3 => nil,
                             4 => nil,
                             5 => nil,
                             6 => nil)
    }
    it { expect(game.indexed_keyword.count).to eq(7) }
    it { expect(game.indexed_keyword).to_not be_empty }
  end

  describe '.indexed_word' do
    subject(:indexed_keyword) { game.indexed_keyword }

    it { is_expected.to_not be_empty }
    it { expect(game.indexed_keyword.count).to eq(7) }
  end

  describe '.search_and_index' do
    
    context 'when is invalid or not included' do
      subject(:search_and_index) { game.search_and_index('p') }

      it { is_expected.to be_nil }
    end

    context 'when is already taken by mistaken/successes array' do
      
    end

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
      subject(:search_and_index) { game.search_and_index('e') }

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
      subject(:search_and_index) { game.search_and_index('e') }

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
