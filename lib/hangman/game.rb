# frozen_string_literal: true

module Game
  def init; end

  def mistakes
    []
  end

  def successes
    []
  end

  def choose(letter); end

  class Word
    # include String

    def has_letter?; end

    def match(input)
      word.eql?(input)
    end
  end
end
