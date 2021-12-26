# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Entities::Puppetable do
  let(:game) { Hangman::Game.new(selected_topic_entity) { include Entities::Puppetable } }
  let(:selected_topic_entity) { build(:topic_entity) }
  let(:letter) { 'x' }

  describe '.mapped_puppet' do
    context 'when missed twice' do
      subject { game.mapped_puppet }
      it { is_expected.to include ({
          'pole' => ' ===| ',
          'head' => '    0  ',
          'body' => '    |  ',
          'left_arm' => '   /|  ',
          'arms' => '   /|\\ ',
          'left_leg' => '   /   ',
          'legs' => '   / \\ '
      })}
    end
  end
end
