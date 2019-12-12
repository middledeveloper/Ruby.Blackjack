# frozen_string_literal: true

require_relative 'card'

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def give_card(deck)
    random_card = Card.take(deck)
    random_card.give(self)
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

    score_with_a(a_count, hand_score)
  end

  def score_with_a(a_count, score)
    if a_count.positive?
      max_with_a = score + 11 + ((a_count - 1) * 1)
      min_with_a = score + 1 + ((a_count - 1) * 1)
      return max_with_a if max_with_a <= 21

      min_with_a
    else
      score
    end
  end
end
