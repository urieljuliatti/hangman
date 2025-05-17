# frozen_string_literal: true

RSpec.shared_examples 'color method' do
  it_behaves_like 'valid color method'
  it_behaves_like 'invalid color method'
  it_behaves_like 'no color method'
end

RSpec.shared_examples 'valid color method' do
  describe '#color with valid color' do
    subject { string.color(color: :red) }

    it { is_expected.to eq "\e[31m\e #{string} \e[0m" }
  end
end

RSpec.shared_examples 'invalid color method' do
  describe '#color with invalid color' do
    subject { string.color(color: :invalid) }

    it { is_expected.to eq "\e[m\e #{string} \e[0m" }
  end
end

RSpec.shared_examples 'no color method' do
  describe '#color with no color' do
    subject { string.color(color: nil) }

    it { is_expected.to eq "\e[m\e #{string} \e[0m" }
  end
end
