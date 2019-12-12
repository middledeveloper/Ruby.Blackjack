# frozen_string_literal: true

require_relative 'card'

class Deck
  attr_accessor :cards

  def initialize
    @cards = []

    generate
  end

  private

  def generate
    Card::TYPES.each do |type|
      Card::VALUES.each do |value|
        @cards.push(Card.new(value, type))
      end
    end
  end
end
