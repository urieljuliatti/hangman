# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Entities::Displayable do
  let(:game) { Hangman::Game.new(selected_topic_entity) { include Entities::Displayable } }
  let(:selected_topic_entity) { build(:topic_entity) }
  let(:letter) { 'c' }

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

  describe '.selected_topic_status' do
    subject { game.selected_topic_status }

    it { is_expected.to eq "\e[33m\e [#{I18n.t('topic.subject')}]: animals and [#{I18n.t('topic.kind')}]: big cats \e[0m" }
    it { is_expected.to match(/animals/) }
  end

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

  describe '.successes_status' do
    subject { game.successes_status }

    before do
      game.answer(letter)
    end

    it { is_expected.to eq "\e[32m\e [#{I18n.t('displayable.successes')}]: 1 => [#{I18n.t('displayable.letters')}]: [\"c\"] \e[0m" }
  end

  describe '.mistakes_status' do
    subject { game.mistakes_status }

    before do
      game.answer('d')
    end

    it { is_expected.to eq "\e[31m\e [#{I18n.t('displayable.mistakes')}]: 1 => [#{I18n.t('displayable.letters')}]: [\"d\"] \e[0m" }
  end

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
