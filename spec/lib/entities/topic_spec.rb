# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Entities::Topic do
  subject(:topic_entity) { build(:topic_entity) }
  let(:display) { "[subject]: \e[1m#{subject}\e[0m and [kind]: \e[1m#{kind} \e[0m" }

  describe 'have attributes' do
    it { is_expected.to have_attributes(subject: 'animals') }
    it { is_expected.to have_attributes(keyword: 'cheetah') }
    it { is_expected.to have_attributes(kind: 'big cats') }
    it { is_expected.to have_attributes(name: 'Cheetah') }
  end

  describe '.display' do
    subject(:display) { topic_entity.display }

    it { is_expected.to eq(display) }
  end
end
