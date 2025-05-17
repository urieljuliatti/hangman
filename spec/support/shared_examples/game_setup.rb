# frozen_string_literal: true

RSpec.shared_examples 'game setup' do |locale|
  it 'creates a new topic repository' do
    expect(Repositories::Topic).to receive(:new)
    described_class.build(locale)
  end

  it 'creates a new game with the selected topic' do
    expect(Hangman::Game).to receive(:new).with(topic_entity)
    described_class.build(locale)
  end

  it 'starts the game' do
    expect(game).to receive(:start)
    described_class.build(locale)
  end
end
