# frozen_string_literal: true

require 'spec_helper'

RSpec.describe UI::TextColor::InstanceMethods do
  let(:string) { 'color' }

  it_behaves_like 'text color methods'

  describe '#color' do
    subject { string.color(color: color) }

    context 'with invalid color' do
      let(:color) { :invalid }

      it { is_expected.to eq "\e[0m\e #{string} \e[0m" }
    end

    context 'with no color' do
      let(:color) { nil }

      it { is_expected.to eq "\e[0m\e #{string} \e[0m" }
    end
  end

  describe '#default_colors' do
    subject { string.send(:default_colors, options) }

    let(:options) { [] }

    it 'sets default color when no color is specified' do
      subject
      expect(options[0]).to eq 0
    end
  end
end
