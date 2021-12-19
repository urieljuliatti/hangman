# frozen_string_literal: true

RSpec.describe Repositories::Topic do
  subject(:topic) { described_class.new }
  let(:selected_entity) { build(:topic) }
  let(:random_id) { 0 }
  let(:random_keyword_id) { 0 }
  let(:subject_word) { 'animals' }
  let(:keyword) { 'cheetah' }
  let(:topic_attributes) do
    {
      subject: 'animals',
      name: 'Cheetah',
      keyword: 'cheetah',
      kind: 'big cats'
    }
  end

  before do
    stub_const("#{described_class}::RANDOM_SUBJECT_ID", random_id)
    stub_const("#{described_class}::RANDOM_KEYWORD_ID", random_keyword_id)
    stub_const("#{described_class}::SUBJECT", subject_word)
    stub_const("#{described_class}::KEYWORD", keyword)
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
end
