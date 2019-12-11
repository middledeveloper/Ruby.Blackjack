# frozen_string_literal: true

require_relative 'game'

game = Game.new

play = true
while play
  puts game.deck.cards.count
  break unless game.enough_cards?
  break unless game.enough_money?

  game.start

  round = true
  round = game.play_round while round

  play = game.restart_game?
end

exit
