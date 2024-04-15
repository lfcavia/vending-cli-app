require_relative 'product'
require_relative 'rule'

class Checkout
  attr_reader :items, :rule

  def initialize(rule)
    @items = []
    @rule = rule
  end

  # Scans all products in basket
  def scan(item)
    @items << item
  end

  # Each discount Rule method called on @rule filters items whith the relevant code
  # before applying the discount calculation
  def total
    total_price = 0
    total_price += @rule.buy_one_get_one_free(@items)
    total_price += @rule.minus_50_cents(@items)
    total_price += @rule.drops_to_two_thirds(@items)
    total_price
  end
end
