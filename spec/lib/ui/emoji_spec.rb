# frozen_string_literal: true

require 'spec_helper'

RSpec.describe UI::Emoji do
  let(:object) { Object.new.extend(described_class) }
  let(:hexadecimal) { 0x1F600 }
  let(:hex_string) { '1F600' }

  describe '.emoji' do
    subject { object.emoji(hexadecimal) }

    it { is_expected.to eq hex_string.hex.chr('UTF-8') }
  end
end
