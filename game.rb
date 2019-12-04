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
    if player.cards.count < 3
      card = deck.cards[rand(0...deck.cards.count)]
      player.cards.push(card)
      deck.cards.delete(card)
    else
      UI.cards_max
    end
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

  def player_cards_info(player)
    puts "#{player.name}, Ваши карты: #{show_cards(player)} " \
    "(сумма очков: #{player_score(player)})"
  end

  def player_progress
    UI.player_progress
    gets.chomp.to_i
  end

  def dealer_progress
    if player_score(players[0]) > 16 || players[0].cards.count > 2
      UI.dealer_passed
    else
      UI.dealer_got_card
      give_card(players[0])
    end
  end

  def players_has_three_cards?
    return true if players[0].cards.count > 2 && players[1].cards.count > 2

    false
  end

  def open_cards
    players.each { |player| player_cards_info(player) }
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
      UI.winner(winner.name, winner.money)
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

  def fund_player(player, money)
    player.money += money
  end

  def restart_game?
    UI.play_again
    return true if gets.chomp.to_i == 1

    false
  end
end
