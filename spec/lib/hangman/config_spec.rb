# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Hangman::Config do
  subject(:config) { described_class }

  let(:selected_topic_entity) { build(:topic_entity) }
  let(:topic) { Repositories::Topic.new(rspec_flag: true) }
  let(:game) { Hangman::Game.new(topic.selected_topic_entity) }
  let(:cheetah_attributes) {
    {
      subject: 'animals',
      keyword: 'cheetah',
      kind: 'big cats',
      name: 'Cheetah'
    }
  }
  describe '.setup' do
    subject { config.setup(topic, game) }

    it { is_expected.to_not be_empty }
    it { is_expected.to include(topic: topic, game: game) }
  end

  describe '.settings' do
    subject(:settings) { config.settings }

    before do
      config.setup(topic, game)
    end

    it { expect(settings).to_not be_empty }
    it { expect(settings[:topic].selected_topic_entity).to have_attributes(cheetah_attributes) }
    it { expect(settings[:game].selected_topic_entity).to have_attributes(cheetah_attributes) }
  end

  # TODO: Aprimorar o STDIN e STDOUT com ruby e aplicar testes adequados
  describe '.greetings' do
    subject { described_class.greetings }

    before do
      # method(:gets).owner == Kernel
      # allow_any_instance_of(Kernel).to receive(:gets).and_return('y')
    end

    context 'when the game begins' do
      # it { is_expected.to eq 'y' }
    end

    context 'when someone gives up' do
      # it { is_expected.to exit }
    end
  end
end
