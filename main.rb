# frozen_string_literal: true

require_relative 'game'

game = Game.new

player = Player.new('Bond')
game.add_player(player)

game.debiting_players

puts game.deck.cards.count

game.give_two_random_cards
game.give_one_random_card(player)

puts game.inspect
puts game.deck.cards.count
