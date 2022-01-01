# frozen_string_literal: true

require './lib/ui/text_color/class_methods'
require './lib/ui/text_color/instance_methods'

# Extend String class
class String
  extend UI::TextColor::ClassMethods
  include UI::TextColor::InstanceMethods

  # métodos para colorir
  color_methods
end
