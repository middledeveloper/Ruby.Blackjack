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
    types = ["\u2660", "\u2665", "\u2666", "\u2663"]
    values = (2..10).to_a.push('J', 'Q', 'K', 'A')

    types.each do |type|
      values.each do |value|
        @cards.push(Card.new(value, type))
      end
    end
  end
end
