# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Hangman::Game do
  subject(:game) { described_class.new(selected_topic_entity) }

  let(:letter) { 'c' }
  # animals / cheetah
  let(:selected_topic_entity) { build(:topic_entity) }

  it_behaves_like 'game mistakes'
  it_behaves_like 'game successes'
  it_behaves_like 'game answers'
  it_behaves_like 'game state'
end
