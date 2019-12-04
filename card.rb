# frozen_string_literal: true

class Card
  # представлять карту, отвечать на вопрос "сколько очков стоит карта"
  attr_reader :value, :type

  def initialize(value, type)
    @value = value
    @type = type
  end
end
