# frozen_string_literal: true

require_relative 'game'

game = Game.new
game.add_player

dealer = game.players[0]
player = game.players[1]
game.deck = Deck.new

play = true
while play
  break unless game.enough_cards?
  break unless game.enough_money?

  game.start

  play_round = true
  while play_round

    if game.all_has_three?
      game.open_cards
      game.game_result
      play_round = false
      break
    end

    case game.player_turn
    when 1
      game.dealer_turn
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

exit
