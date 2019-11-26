# frozen_string_literal: true

require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = []

    self.class.card_types = ["\u2660", "\u2665", "\u2666", "\u2663"]
    self.class.card_values = (2..10).to_a.push('J', 'Q', 'K', 'A')
    generate_deck
  end

  def generate_deck
    self.class.card_types.each do |type|
      self.class.card_values.each do |value|
        @cards.push(Card.new(value, type))
      end
    end
  end

  def print
    puts @cards.inspect
  end

  class << self
    attr_accessor :card_types, :card_values
  end
end

deck = Deck.new
puts deck.inspect
puts deck.cards[3].inspect

deck.print
puts deck.cards.count
