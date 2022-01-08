# frozen_string_literal: true

require 'spec_helper'

RSpec.describe UI::TextColor::ClassMethods do
  subject(:dummy_class) { Class.new { extend described_class } }
  
end
