# frozen_string_literal: true

require_relative 'game'
play = true

puts '*** Добро пожаловать в игру RUBY Blackjack! ***'
print 'Укажите Ваше имя: '

game = Game.new
game.add_player(Player.new(gets.chomp))
dealer = game.players[0]
player = game.players[1]

while play
  puts 'Новая игра началась!'
  dealer.cards = []
  player.cards = []
  game.deck = Deck.new
  game.debiting_players
  game.give_two_cards_each_player

  game.player_cards_info(player)

  if game.players_has_three_cards?
    game.open_cards
    game.game_result
    play = game.restart_game?
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
    play = game.restart_game?
  end

end

puts '*** Спасибо за игру, возвращайтесь! ***'
exit
