# frozen_string_literal: true

class Card
  attr_reader :value, :type

  def initialize(value, type)
    @value = value
    @type = type
  end
end
