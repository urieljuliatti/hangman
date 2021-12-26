# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Entities::Displayable do
  let(:game) { Hangman::Game.new(selected_topic_entity) { include Entities::Displayable } }
  let(:selected_topic_entity) { build(:topic_entity) }
  let(:letter) { 'c' }

  describe '.answer_feedback' do
    context 'when is true' do
      subject { game.answer_feedback(true) }

      it { is_expected.to eq "\e[42m\e[39m\e[5m Right answer! \e[0m" }
      it { is_expected.to match(/Right answer! /) }
    end

    context 'when is false' do
      subject { game.answer_feedback(false) }

      it { is_expected.to eq "\e[40m\e[41m\e[5m Wrong answer! \e[0m" }
      it { is_expected.to match(/Wrong answer! /) }
    end
  end

  describe '.selected_topic_status' do
    subject { game.selected_topic_status }

    it { is_expected.to eq "[subject]: \e[1manimals\e[0m and [kind]: \e[1mbig cats \e[0m" }
    it { is_expected.to match(/animals/) }
  end

  describe '.keyword_status' do
    subject { game.keyword_status }

    before do
      game.answer(letter)
    end

    it { is_expected.to eq "\e[40m\e [keyword]:  c   _   _   _   _   _   _  \e[0m" }
    it { is_expected.to match(/c   _/) }
  end

  describe '.successes_status' do
    subject { game.successes_status }

    before do
      game.answer(letter)
    end

    it { is_expected.to eq "\e[42m\e[39m\e [successes]: 1 => [letters]: [\"c\"] \e[0m" }
  end

  describe '.mistakes_status' do
    subject { game.mistakes_status }

    before do
      game.answer('d')
    end

    it { is_expected.to eq "\e[41m\e[39m\e [mistakes]: 1 => [letters]: [\"d\"] \e[0m" }
  end

  describe '.end_game_message' do
    context 'winner' do
      subject { game.end_game_message }

      before do
        allow(game).to receive(:won?).and_return(true)
      end

      it { is_expected.to eq 'You won!' }
    end
    context 'game over' do
      subject { game.end_game_message }

      before do
        allow(game).to receive(:game_over?).and_return(true)
      end

      it { is_expected.to eq 'You lose!' }
    end
  end
end
