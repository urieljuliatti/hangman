# frozen_string_literal: true

require 'spec_helper'
require_relative '../../support/shared_examples/game_setup'

RSpec.describe Hangman::Config do
  let(:topic) { instance_double('Repositories::Topic') }
  let(:topic_entity) { instance_double('TopicEntity', keyword: 'RUBY') }
  let(:game) { instance_double('Hangman::Game') }

  before do
    allow(Repositories::Topic).to receive(:new).and_return(topic)
    allow(topic).to receive(:selected_topic_entity).and_return(topic_entity)
    allow(Hangman::Game).to receive(:new).with(topic_entity).and_return(game)
    allow(game).to receive(:start)
  end

  describe '.build' do
    context 'with brazilian portuguese' do
      it 'sets the default locale to brazilian portuguese' do
        described_class.build('pt-BR')
        expect(I18n.default_locale).to eq(:"pt-BR")
      end

      it_behaves_like 'game setup', 'pt-BR'
    end

    context 'with english' do
      it 'sets the default locale to english' do
        described_class.build('en')
        expect(I18n.default_locale).to eq(:en)
      end

      it_behaves_like 'game setup', 'en'
    end
  end
end
