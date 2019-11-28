# frozen_string_literal: true

class Player
  attr_reader :name
  attr_accessor :cards, :money

  def initialize(name)
    @name = name
    @cards = []
    @money = 100
  end
end
