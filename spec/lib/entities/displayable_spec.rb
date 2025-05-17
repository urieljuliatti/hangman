# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Entities::Displayable do
  let(:game) { Hangman::Game.new(selected_topic_entity) { include Entities::Displayable } }
  let(:selected_topic_entity) { build(:topic_entity) }
  let(:letter) { 'c' }

  it_behaves_like 'feedback messages'
  it_behaves_like 'status messages'
  it_behaves_like 'game state messages'
end
