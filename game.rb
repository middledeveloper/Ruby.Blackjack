# frozen_string_literal: true

require_relative 'bank'
require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'ui'

class Game
  attr_reader :players
  attr_accessor :deck, :bank

  def initialize
    @players = [Player.new('Дилер')]
    @bank = Bank.new
    @deck = Deck.new

    @players.push(Player.new(UI.add_player))
  end

  def start
    players.each do |player|
      player.hand.cards = []
      bank.take(player, 10)

      2.times { take_card(player) }
    end

    UI.start
    open_cards(players[1])
  end

  def play_round
    return false if all_has_three?

    case player_turn
    when 1
      dealer_turn
    when 2
      take_card(players[1])
      open_cards(players[1])

      dealer_turn
    when 3
      game_result
      return false
    end
  end

  def take_card(player)
    if player.hand.cards.count < 3
      player.hand.give_card(deck)
    else
      UI.cards_max
    end
  end

  def enough_cards?
    if deck.cards.count < 5
      UI.no_cards(deck.cards.count)
      return false
    end

    true
  end

  def enough_money?
    players.each do |player|
      if player.money.zero?
        UI.no_money(player.name)
        return false
      end
    end

    true
  end

  def all_has_three?
    count = players.count { |player| player.hand.cards.count == 3 }
    if count > 1
      UI.three_cards
      game_result
      return true
    end

    false
  end

  def player_turn
    UI.player_turn
  end

  def dealer_turn
    if players[0].hand.score > 16 || players[0].hand.cards.count > 2
      UI.dealer_passed
    else
      UI.dealer_got_card
      take_card(players[0])
    end

    true
  end

  def open
    players.each do |player|
      open_cards(player)
    end
  end

  def open_cards(player)
    view = player.hand.show
    UI.show_hand(player.name, view)
  end

  def finish
    winner = define_winner(players[0].hand.score, players[1].hand.score)
    if winner.nil?
      UI.draw
      players.each { |player| bank.give(player, 10) }
    else
      bank.give(winner, bank.money)
      UI.winner(winner.name, winner.hand.score, winner.money)
    end
  end

  def game_result
    open
    finish
  end

  def define_winner(p1_score, p2_score)
    limit = 21
    if p1_score > limit || p2_score > limit
      return players[0] if p2_score > limit && p1_score <= limit
      return players[1] if p1_score > limit && p2_score <= limit
      return nil if p2_score > limit && p1_score > limit
    else
      return players[0] if p1_score > p2_score
      return players[1] if p2_score > p1_score
      return nil if p1_score == p2_score
    end
  end

  def restart_game?
    return true if UI.play_again == 1

    UI.end
    false
  end
end
