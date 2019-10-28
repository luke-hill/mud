# frozen_string_literal: true

module Items
  class Gold
    attr_reader :name, :desc, :amount

    def initialize(amount)
      @name = 'Gold'
      @desc = 'Glistening in your hand, these gold coins are trade-able at just about any shop'
      @amount = amount
    end
  end
end
