# frozen_string_literal: true

require_relative 'ui'
require_relative 'game'

UI.greetings

game = Game.new
game.add_player(Player.new(gets.chomp))
dealer = game.players[0]
player = game.players[1]
game.deck = Deck.new

play = true
while play
  UI.start

  if game.deck.cards.count < 5
    UI.no_cards(game.deck.cards.count)
    break
  end

  game.players.each do |player|
    if player.money == 0
      UI.no_money(player.name)
      break
    end
  end

  game.bank = 0
  dealer.cards = []
  player.cards = []
  game.debiting_players
  game.give_two_cards_each_player

  game.player_cards_info(player)

  play_round = true
  while play_round

    if game.players_has_three_cards?
      game.open_cards
      game.game_result
      play_round = false
      break
    end

    case game.player_progress
    when 1
      game.dealer_progress
    when 2
      game.give_card(player)
      game.player_cards_info(player)
      game.dealer_progress
    when 3
      game.open_cards
      game.game_result
      play_round = false
    end
  end

  play = game.restart_game?
end

UI.end
exit
