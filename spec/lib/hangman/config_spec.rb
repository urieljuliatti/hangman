# frozen_string_literal: true

RSpec.describe Config do
  describe '.greetings' do
    subject { described_class.greetings }
    before do
      # method(:gets).owner == Kernel
      allow_any_instance_of(Kernel).to receive(:gets).and_return('y')
    end
    context 'when the game begins' do
      it { is_expected.to eq 'y' }
    end
    context 'when someone gives up' do
      it { is_expected.to exit }
    end
  end
end
