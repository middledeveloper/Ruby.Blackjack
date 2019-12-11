# frozen_string_literal: true

class UI
  class << self
    def greetings
      puts '*** Добро пожаловать в игру RUBY Blackjack! ***'
    end

    def add_player
      print 'Укажите Ваше имя: '
      gets.chomp.capitalize
    end

    def start
      puts 'Новая игра началась!'
    end

    def no_cards(cards_count)
      puts "Карт в колоде мало (#{cards_count} шт.), пора заканчивать!"
    end

    def no_money(name)
      puts "У игрока (#{name} нулевой баланс, пора заканчивать!"
    end

    def cards_max
      puts 'У Вас максимальное количество карт!'
    end

    def three_cards
      puts 'У обоих игроков максимальное количество карт, открываемся!'
    end

    def player_turn
      puts 'Ход игрока:'
      print '1 = Пропустить; 2 = Взять карту; 3 = Открыться: '
      gets.chomp.to_i
    end

    def dealer_passed
      puts 'Дилер пропустил ход!'
    end

    def dealer_got_card
      puts 'Дилер взял карту!'
    end

    def show_hand(player_name, cards_view)
      puts "Карты игрока #{player_name}: #{cards_view}"
    end

    def draw
      puts 'Ничья! Возвращаем ставки игрокам!'
    end

    def winner(name, score, money)
      puts "#{name} побеждает (#{score} оч.), теперь на счету $#{money}!"
    end

    def play_again
      print 'Сыграем еще раз? 1 = Да; 0 = Нет: '
      gets.chomp.to_i
    end

    def end
      puts '*** Спасибо за игру, возвращайтесь! ***'
    end
  end
end
