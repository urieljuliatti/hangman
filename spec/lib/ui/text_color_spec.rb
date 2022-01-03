# frozen_string_literal: true

require 'spec_helper'

RSpec.describe UI::TextColor do
  let(:class_methods) { described_class { extend UI::TextColor::ClassMethods } }
  let(:class_methods) { described_class { include UI::TextColor::InstanceMethods } }

end
