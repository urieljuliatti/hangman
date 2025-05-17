# frozen_string_literal: true

RSpec.shared_examples 'text color methods' do
  it_behaves_like 'color method'
  it_behaves_like 'default colors method'
  it_behaves_like 'colors method'
end

RSpec.shared_examples 'color method' do
  describe '#color' do
    subject { string.color(color: color) }

    context 'with valid color' do
      let(:color) { :red }

      it { is_expected.to eq "\e[0m\e #{string} \e[0m" }
    end

    context 'with invalid color' do
      let(:color) { :invalid }

      it { is_expected.to eq "\e[0m\e #{string} \e[0m" }
    end

    context 'with no color' do
      let(:color) { nil }

      it { is_expected.to eq "\e[0m\e #{string} \e[0m" }
    end
  end
end

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

RSpec.shared_examples 'colors method' do
  describe '#colors' do
    subject { string.send(:colors, options, symbol) }

    let(:options) { [] }
    let(:symbol) { { color: :red } }

    it 'sets color code for valid color' do
      subject
      options[0] = 31
      expect(options[0]).to eq 31
    end
  end
end
