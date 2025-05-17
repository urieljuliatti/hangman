# frozen_string_literal: true

RSpec.shared_examples 'search and index' do
  it_behaves_like 'single letter index'
  it_behaves_like 'repeated letter index'
  it_behaves_like 'multiple letters index'
end

RSpec.shared_examples 'single letter index' do
  describe 'when indexes a single letter' do
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
end

RSpec.shared_examples 'repeated letter index' do
  describe 'when indexes a repeated letter' do
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
end

RSpec.shared_examples 'multiple letters index' do
  describe 'when indexes multiple letters' do
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
