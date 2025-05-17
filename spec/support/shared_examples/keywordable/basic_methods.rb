# frozen_string_literal: true

RSpec.shared_examples 'basic methods' do
  it_behaves_like 'included method'
  it_behaves_like 'taken method'
  it_behaves_like 'whitespaces method'
  it_behaves_like 'selected topic entity letters'
  it_behaves_like 'repeated letters'
  it_behaves_like 'build indexed keyword'
  it_behaves_like 'indexed word'
end

RSpec.shared_examples 'included method' do
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
end

RSpec.shared_examples 'taken method' do
  describe '.taken?' do
    context 'when letter have been already taken' do
      subject { game.taken?('e') }

      before do
        game.answer('e')
      end

      it { is_expected.to be_truthy }
    end
  end
end

RSpec.shared_examples 'whitespaces method' do
  describe '.whitespaces' do
    context 'when return all whitespaces' do
      let(:selected_topic_entity) { build(:topic_entity, :with_whitespace) }
      subject { game.whitespaces }

      it { is_expected.to include({ whitespace_indexes: [3] }) }
    end
  end
end

RSpec.shared_examples 'selected topic entity letters' do
  describe '.selected_topic_entity_letters' do
    subject { game.selected_topic_entity_letters }

    it { is_expected.to_not be_empty }
    it { is_expected.to match_array %w[c h e e t a h] }
    it { is_expected.to contain_exactly('c', 'h', 'e', 'e', 't', 'a', 'h') }
  end
end

RSpec.shared_examples 'repeated letters' do
  describe '.repeated_letters' do
    context 'when a letter is repeated' do
      subject { game.repeated_letters('e') }

      it { is_expected.to_not be_empty }
      it { is_expected.to include(ids: [2, 3], letters: %w[e e]) }
    end
  end
end

RSpec.shared_examples 'build indexed keyword' do
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
end

RSpec.shared_examples 'indexed word' do
  describe '.indexed_word' do
    subject(:indexed_keyword) { game.indexed_keyword }

    it { is_expected.to_not be_empty }
    it { expect(game.indexed_keyword.count).to eq(7) }
  end
end
