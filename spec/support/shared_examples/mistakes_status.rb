# frozen_string_literal: true

RSpec.shared_examples 'mistakes status' do
  describe '.mistakes_status' do
    subject { game.mistakes_status }

    before do
      game.answer('d')
    end

    it {
      is_expected.to eq "\e[31m\e [#{I18n.t('displayable.mistakes')}]: 1 => " \
                       "[#{I18n.t('displayable.letters')}]: [\"d\"] \e[0m"
    }
  end
end
