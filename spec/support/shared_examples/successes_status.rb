# frozen_string_literal: true

RSpec.shared_examples 'successes status' do
  describe '.successes_status' do
    subject { game.successes_status }

    before do
      game.answer(letter)
    end

    it {
      is_expected.to eq "\e[32m\e [#{I18n.t('displayable.successes')}]: 1 => " \
                       "[#{I18n.t('displayable.letters')}]: [\"c\"] \e[0m"
    }
  end
end
