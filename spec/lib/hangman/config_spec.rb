# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Hangman::Config do
  subject(:config) { described_class }

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

  before do
    settings = {}
    settings[:topic] = topic
    settings[:game] = game
    described_class.class_variable_set :@@settings, settings
    
    allow(config).to receive(:setup).and_return(settings)
  end

  describe '.setup' do
    subject { config.setup }

    it { is_expected.to_not be_empty }
    it { is_expected.to include(topic: topic, game: game) }
  end

  describe '.settings' do
    subject(:settings) { config.settings }

    it { expect(settings).to_not be_empty }
    it { expect(settings[:topic].selected_topic_entity).to have_attributes(cheetah_attributes) }
    it { expect(settings[:game].selected_topic_entity).to have_attributes(cheetah_attributes) }
  end
end
