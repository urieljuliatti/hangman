# frozen_string_literal: true

RSpec.describe Base do
  before do
    stub_const('WORDS', %w[zelda mario sonic kratos])
  end

  describe '.fetch' do
    subject { described_class.fetch(key)}
    let(:key) { 'mario' }

    xit { is_expected.to eq 'mario' }
    xit { is_expected.not_to be_nil }
    xit { is_expected.not_to be_empty }
  end

  describe '.random' do
    subject { described_class.random }
    let(:selected_option) { 'zelda' }

    xit { is_expected.to_not be_nil }
    xit { is_expected.to_not be_empty }
    xit { is_expected.to be_a(String) }
    xit { expect(WORDS).to include(selected_option) }
  end
end
