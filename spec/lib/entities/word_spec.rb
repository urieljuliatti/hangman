# frozen_string_literal: true

RSpec.describe Entities::Word do
  let(:random_id) { 0 }
  let(:random_keyword_id) { 0 }
  let(:subject_word) { 'animals' }
  let(:keyword) { 'cheetah' }
  let(:letters) { %w[c h e e t a h] }
  let(:letter) { 'a' }
  let(:topic) { Repositories::Topic }

  before do
    stub_const("#{topic}::RANDOM_SUBJECT_ID", random_id)
    stub_const("#{topic}::RANDOM_KEYWORD_ID", random_keyword_id)
    stub_const("#{topic}::SUBJECT", subject_word)
    stub_const("#{topic}::KEYWORD", keyword)
  end

  describe '#letters' do
    subject { described_class.letters }

    it { is_expected.to match_array(letters) }
  end

  describe '#inclued?' do
    subject { described_class.include?(letter) }

    it { is_expected.to be_truthy }
  end
end
