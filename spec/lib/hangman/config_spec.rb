# frozen_string_literal: true

require 'spec_helper'

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

      it 'creates a new topic repository' do
        expect(Repositories::Topic).to receive(:new)
        described_class.build('pt-BR')
      end

      it 'creates a new game with the selected topic' do
        expect(Hangman::Game).to receive(:new).with(topic_entity)
        described_class.build('pt-BR')
      end

      it 'starts the game' do
        expect(game).to receive(:start)
        described_class.build('pt-BR')
      end
    end

    context 'with english' do
      it 'sets the default locale to english' do
        described_class.build('en')
        expect(I18n.default_locale).to eq(:en)
      end

      it 'creates a new topic repository' do
        expect(Repositories::Topic).to receive(:new)
        described_class.build('en')
      end

      it 'creates a new game with the selected topic' do
        expect(Hangman::Game).to receive(:new).with(topic_entity)
        described_class.build('en')
      end

      it 'starts the game' do
        expect(game).to receive(:start)
        described_class.build('en')
      end
    end
  end
end
