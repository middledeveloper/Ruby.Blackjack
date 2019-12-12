# frozen_string_literal: true

class Card
  attr_reader :value, :type

  TYPES = ["\u2660", "\u2665", "\u2666", "\u2663"].freeze
  VALUES = (2..10).to_a.push('J', 'Q', 'K', 'A').freeze

  def initialize(value, type)
    @value = value
    @type = type
  end

  def self.take(deck)
    card = deck.cards.sample
    deck.cards.delete(card)

    card
  end

  def give(hand)
    hand.cards.push(self)
  end

  def score
    if %w[J Q K].include? value
      10
    elsif value != 'A'
      value
    end
  end

  def show
    "#{value}#{type} "
  end
end
