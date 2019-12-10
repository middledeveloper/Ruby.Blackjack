# frozen_string_literal: true

class Bank
  attr_accessor :money

  def initialize
    @money = 0
  end

  def give(player, money)
    player.money += money
    self.money -= money
  end

  def take(player, money)
    player.money -= money
    self.money += money
  end
end
