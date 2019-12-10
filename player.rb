# frozen_string_literal: true

require_relative 'hand'

class Player
  attr_reader :name
  attr_accessor :hand, :money

  def initialize(name)
    @name = name
    @hand = Hand.new
    @money = 100
  end
end
