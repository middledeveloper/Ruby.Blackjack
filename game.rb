# frozen_string_literal: true

require_relative 'card'
require_relative 'deck'
require_relative 'player'

class Game
  attr_reader :players, :deck
  attr_accessor :bank

  def initialize
    @bank = 0
    (@players ||= []).push(Player.new('Dealer'))
    @deck = Deck.new
  end

  def add_player(player)
    players.push(player)
  end

  def give_two_random_cards
    players.each do |player|
      2.times do
        card = deck.cards[rand(0..deck.cards.count)]
        player.cards.push(card)
        deck.cards.delete(card)
      end
    end
  end

  def give_one_random_card(player)
    card = deck.cards[rand(0..deck.cards.count)]
    player.cards.push(card)
    deck.cards.delete(card)
  end

  def debiting_players
    players.each do |player|
      player.money -= 10
      self.bank += 10
    end
  end
end
