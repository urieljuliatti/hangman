# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable Metrics/BlockLength

RSpec.describe Repositories::Topic do
  subject(:topic) { described_class.new }
  let(:selected_entity) { build(:topic_entity) }
  let(:random_subject_id) { 0 }
  let(:random_keyword_id) { 0 }
  let(:subject_word) { 'animals' }
  let(:keyword) { 'cheetah' }
  let(:randomized_attributes) do
    {
      random_subject_id: random_subject_id,
      random_keyword_id: random_keyword_id,
      keyword: keyword,
      subject: subject_word
    }
  end
  let(:topic_attributes) do
    {
      subject: 'animals',
      name: 'Cheetah',
      keyword: 'cheetah',
      kind: 'big cats'
    }
  end

  before do
    allow(topic).to receive(:randomized).and_return(randomized_attributes)
  end

  describe '.selected_topic' do
    subject(:selected_topic_entity) { topic.selected_topic_entity }
    it { is_expected.to have_attributes topic_attributes }
  end

  describe '.select_topic' do
    subject(:selected_topic_entity) { topic.select_topic_entity }
    it { is_expected.to eql selected_entity }
  end

  describe '.randomized' do
    subject(:randomized) { topic.randomized }
    it { is_expected.to eql randomized_attributes }
  end
end
# rubocop:enable Metrics/BlockLength
