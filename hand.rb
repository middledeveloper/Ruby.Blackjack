# frozen_string_literal: true

require_relative 'card'

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def give_card(deck)
    if cards.count <= 3
      random_card = Card.take(deck)
      random_card.give(self)
    else
      UI.cards_max
    end
  end

  def show
    view = ''
    cards.each do |card|
      view += card.show
    end

    view
  end

  def score
    hand_score = 0
    a_count = 0

    cards.each do |card|
      if card.value != 'A'
        hand_score += card.score
      else
        a_count += 1
      end
    end

    hand_score = a_score(a_count, hand_score) if a_count > 0
  end

  private

  def a_score(a_count, current_score)
    base_count = a_count
    until a_count < 1
      max_score = (a_count * 11 + current_score) + (base_count - a_count * 1)
      if max_score > 21
        a_count -= 1
      else
        return max_score
      end
    end
  end
end
