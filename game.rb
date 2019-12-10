# frozen_string_literal: true

require_relative 'card'
require_relative 'deck'
require_relative 'bank'
require_relative 'player'
require_relative 'ui'

class Game
  attr_reader :players
  attr_accessor :deck, :bank

  def initialize
    @players = [Player.new('Дилер')]
    @bank = Bank.new
    @deck = Deck.new
  end

  def add_player
    players.push(Player.new(UI.add_player))
  end

  def start
    players.each do |player|
      2.times { player.hand.give_card(deck) }
      bank.take(player, 10)
    end

    UI.start
    UI.show_hand(players[1].hand.show)
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
      if player.money == 0
        UI.no_money(player.name)
        return false
      end
    end

    true
  end

  def all_has_three?
    count = players.count { |player| player.hand.cards.count == 3 }
    return true if count > 1

    false
  end

  def player_turn
    UI.player_turn
  end

  def dealer_turn
    if player_score(players[0]) > 16 || players[0].items.count > 2
      UI.dealer_passed
    else
      UI.dealer_got_card
      random_card = Card.take(deck)
      random_card.give(players[0].hand)
    end
  end

  def game_result
    dealer_score = player_score(players[0])
    player_score = player_score(players[1])
    winner = define_winner(dealer_score, player_score)
    if winner.nil?
      UI.draw
      players.each { |player| fund_player(player, 10) }
    else
      fund_player(winner, bank)
      UI.winner(winner.name, winner.count)
    end

    bank = 0
  end

  def define_winner(dealer_score, player_score)
    limit = 21
    if dealer_score > limit || player_score > limit
      return players[0] if player_score > limit && dealer_score <= limit
      return players[1] if dealer_score > limit && player_score <= limit
      return nil if player_score > limit && dealer_score > limit
    else
      return players[0] if dealer_score > player_score
      return players[1] if player_score > dealer_score
      return nil if dealer_score == player_score
    end
  end

  def restart_game?
    return true if UI.play_again == 1

    false
  end
end
