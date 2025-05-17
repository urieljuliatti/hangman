# frozen_string_literal: true

RSpec.shared_examples 'feedback messages' do
  describe '.answer_feedback' do
    context 'when is true' do
      subject { game.answer_feedback(true) }

      it { is_expected.to eq "\e[32m\e  \u{1F7E2} #{I18n.t('displayable.right_answer')} \e[0m" }
      it { is_expected.to match(/#{I18n.t('displayable.right_answer')} /) }
    end

    context 'when is false' do
      subject { game.answer_feedback(false) }

      it { is_expected.to eq "\e[31m\e \u{1F6A8} #{I18n.t('displayable.wrong_answer')} \e[0m" }
      it { is_expected.to match(/#{I18n.t('displayable.wrong_answer')} /) }
    end
  end
end
