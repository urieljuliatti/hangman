# frozen_string_literal: true

RSpec.shared_examples 'status messages' do
  it_behaves_like 'topic status'
  it_behaves_like 'keyword status'
end

RSpec.shared_examples 'topic status' do
  describe '.selected_topic_status' do
    subject { game.selected_topic_status }

    it {
      is_expected.to eq "\e[33m\e [#{I18n.t('topic.subject')}]: animals and [#{I18n.t('topic.kind')}]: big cats \e[0m"
    }
    it { is_expected.to match(/animals/) }
  end
end

RSpec.shared_examples 'keyword status' do
  describe '.keyword_status' do
    context 'when keyword hasnt whitespace' do
      subject { game.keyword_status }

      before do
        game.answer(letter)
      end

      it { is_expected.to eq "\e[36m\e [#{I18n.t('displayable.keyword')}]:  c   _   _   _   _   _   _  \e[0m" }
      it { is_expected.to match(/c   _/) }
    end

    context 'when keyword has whitespace' do
      let(:selected_topic_entity) { build(:topic_entity, :with_whitespace) }

      subject { game.keyword_status }

      before do
        game.answer('n')
        game.whitespaces
      end

      it { is_expected.to eq "\e[36m\e [#{I18n.t('displayable.keyword')}]:  n   _   _     _   _   _   _  \e[0m" }
    end
  end
end
