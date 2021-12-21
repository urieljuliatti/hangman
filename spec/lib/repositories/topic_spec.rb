# frozen_string_literal: true

RSpec.describe Repositories::Topic do
  subject(:topic) { described_class.new }
  let(:topic_double) { double("Repositories::Topic") }
  let(:selected_entity) { build(:topic) }
  let(:random_subject_id) { 0 }
  let(:random_keyword_id) { 0 }
  let(:subject_word) { 'animals' }
  let(:keyword) { 'cheetah' }
  let(:randomized_attributes) {
    {
      random_subject_id: random_subject_id,
      random_keyword_id: random_keyword_id,
      keyword: keyword,
      subject: subject_word
    }
  }
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
    context 'when strtuct is filled in properly' do
      subject(:selected_topic) { topic.selected_topic }

      it { is_expected.to have_attributes topic_attributes }
    end
  end

  describe '.select_topic' do
    context 'when random topic is generated' do
      subject(:selected_topic) { topic.select_topic }

      it { is_expected.to eql selected_entity }
    end
  end

  describe '.randomized' do
    context 'when random values are generated' do
      subject(:randomized) { topic.randomized }

      it { is_expected.to eql randomized_attributes }
    end
  end

end
