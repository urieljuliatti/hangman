# frozen_string_literal: true

RSpec.shared_examples 'end game messages' do
  describe '.end_game_message' do
    context 'winner' do
      subject { game.end_game_message }

      before do
        allow(game).to receive(:won?).and_return(true)
      end

      it { is_expected.to eq I18n.t('displayable.you_won') }
    end
    context 'game over' do
      subject { game.end_game_message }

      before do
        allow(game).to receive(:game_over?).and_return(true)
      end

      it { is_expected.to eq I18n.t('displayable.you_lose') }
    end
  end
end
