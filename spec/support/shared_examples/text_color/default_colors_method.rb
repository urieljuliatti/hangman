# frozen_string_literal: true

RSpec.shared_examples 'default colors method' do
  describe '#default_colors' do
    subject { string.send(:default_colors, options) }

    let(:options) { [] }

    it 'sets default color when no color is specified' do
      subject
      expect(options[0]).to eq 0
    end
  end
end
