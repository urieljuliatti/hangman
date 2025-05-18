# frozen_string_literal: true

module Entities
  # Responsible for visual aspects: colors and what is displayed on screen
  module Puppetable
    def mapped_puppet
      {
        'pole' => pole,
        'head' => head,
        'body' => body,
        'left_arm' => left_arm,
        'arms' => arms,
        'left_leg' => left_leg,
        'legs' => legs
      }
    end

    def hangman # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity
      case mistakes.size
      when 1
        puts pole
      when 2
        puts pole
        puts head
      when 3
        puts pole
        puts head
        puts body
      when 4
        puts pole
        puts head
        puts left_arm
      when 5
        puts pole
        puts head
        puts arms
      when 6
        puts pole
        puts head
        puts arms
        puts left_leg
      when 7
        puts pole
        puts head
        puts arms
        puts legs
      end
    end

    private

    def pole
      ' ===| '
    end

    def head
      '    0  '
    end

    def body
      '    |  '
    end

    def left_arm
      '   /|  '
    end

    def arms
      '   /|\ '
    end

    def left_leg
      '   /   '
    end

    def legs
      '   / \ '
    end
  end
end
