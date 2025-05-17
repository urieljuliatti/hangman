# frozen_string_literal: true

RSpec.shared_examples 'colors method' do
  describe '#colors' do
    subject { string.send(:colors, options, symbol) }

    let(:options) { [] }
    let(:symbol) { { color: :red } }

    it 'sets color code for valid color' do
      subject
      expect(options[0]).to eq 31
    end
  end
end
