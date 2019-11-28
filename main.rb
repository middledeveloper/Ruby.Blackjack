# frozen_string_literal: true

require_relative 'game'
go = true

puts '*** Добро пожаловать в игру RUBY Blackjack! ***'
print 'Укажите Ваше имя: '

player_name = gets.chomp

game = Game.new
game.add_player(Player.new(player_name))

while go
  game.players[0].cards = []
  game.players[1].cards = []
  game.deck = Deck.new
  game.debiting_players
  game.give_two_cards_each_player
  gamer_score = game.player_score(game.players[1])
  puts "#{player_name}, Ваши карты: #{game.show_cards(game.players[1])} " \
  "(сумма очков: #{gamer_score})"

  # print '..end'
  # gets.chomp
end
