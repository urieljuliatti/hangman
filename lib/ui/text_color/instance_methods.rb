# frozen_string_literal: true

module UI
  module TextColor
    # Here are the instance methods for each string: color, remove color, etc.
    module InstanceMethods
      # Método que colore
      def color(symbol)
        options = Array.new(1)
        colors(options, symbol)
        default_colors(options)
        "\e[#{options[0]}m\e #{self} \e[0m"
      end

      private

      def foreground_color(color)
        self.class.color_codes[color]
      end

      def default_colors(options)
        options[0] ||= foreground_color(:default)
      end

      def colors(options, symbol)
        options[0] = foreground_color(symbol) if foreground_color(symbol)
      end
    end
  end
end
