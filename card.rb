# frozen_string_literal: true

class Card
  attr_reader :value, :type

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
