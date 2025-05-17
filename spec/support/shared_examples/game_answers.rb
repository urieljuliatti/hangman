# frozen_string_literal: true

RSpec.shared_examples 'game answers' do
  describe '.answer' do
    subject(:answer) { game.answer(letter) }

    it_behaves_like 'taken letter answer'
    it_behaves_like 'mistaken letter answer'
    it_behaves_like 'correct letter answer'
    it_behaves_like 'whitespace word answer'
  end
end

RSpec.shared_examples 'taken letter answer' do
  before do
    game.answer('c')
  end
  it { is_expected.to be_nil }
end

RSpec.shared_examples 'mistaken letter answer' do
  let(:letter) { 'd' }

  before do
    answer
  end

  it { expect(game.mistakes).to_not be_empty }
  it { expect(game.mistakes).to contain_exactly('d') }
  it { expect(game.mistakes).to match_array ['d'] }
  it { is_expected.to be_falsey }
end

RSpec.shared_examples 'correct letter answer' do
  let(:letter) { 'e' }

  before do
    answer
  end

  it { expect(game.successes).to_not be_empty }
  it { expect(game.successes).to contain_exactly('e') }
  it { expect(game.successes).to match_array ['e'] }
  it { is_expected.to be_truthy }
end

RSpec.shared_examples 'whitespace word answer' do
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
