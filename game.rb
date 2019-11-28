# frozen_string_literal: true

require_relative 'card'
require_relative 'deck'
require_relative 'player'

class Game
  attr_reader :players
  attr_accessor :deck, :bank

  def initialize
    @bank = 0
    (@players ||= []).push(Player.new('Dealer'))
    @deck = Deck.new
  end

  def add_player(player)
    players.push(player)
  end

  def give_two_cards_each_player
    players.each { |player| 2.times { give_card(player) } }
  end

  def give_card(player)
    card = deck.cards[rand(0...deck.cards.count)]
    player.cards.push(card)
    deck.cards.delete(card)
  end

  def debiting_players
    players.each do |player|
      player.money -= 10
      self.bank += 10
    end
  end

  def show_cards(player)
    cards = ''
    player.cards.each { |card| cards += "#{card.value}#{card.type} " }
    cards
  end

  def player_score(player)
    score = 0
    ten_points_values = %w[J Q K]
    player.cards.each do |card|
      score += if ten_points_values.include? card.value
                 10
               elsif card.value == 'A'
                 if score + 11 <= 21
                   11
                 else
                   1
                 end
               else
                 card.value.to_i
               end
    end

    score
  end
end
