# frozen_string_literal: true

module UI
  module TextColor
    # Aqui fica a coleção de métodos para a montagem e preparo das cores, backgrounds e modos
    module ClassMethods
      COLOR_CODES = {
        default: 0,
        black: 30,
        red: 31,
        green: 32,
        yellow: 33,
        blue: 34,
        magenta: 35,
        cyan: 36,
        gray: 37
      }.freeze

      # Returns an array of available colors
      def colors
        color_codes.keys
      end

      # UNIX color codes hash
      def color_codes
        COLOR_CODES
      end

      # Criando métodos de instância dinamicamente para as cores
      def color_methods
        colors.each do |key|
          next if key == :default

          define_color_methods(key)
        end
      end

      private

      def define_color_methods(key)
        define_method key do
          color(color: key)
        end

        define_method "on_#{key}" do
          color(background: key)
        end
      end
    end
  end
end
