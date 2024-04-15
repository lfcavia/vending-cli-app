require_relative '../lib/checkout'
require_relative '../lib/product'
require_relative '../lib/rule'

RSpec.describe Checkout do
  let(:green_tea) { Product.new('GR1', 'Green Tea', 3.11) }
  let(:strawberries) { Product.new('SR1', 'Strawberries', 5.00) }
  let(:coffee) { Product.new('CF1', 'Coffee', 11.23) }
  let(:rule) { Rule.new }
  let(:checkout) { Checkout.new(rule) }

  before do
    @rule = Rule.new
    checkout.scan(green_tea)
    checkout.scan(strawberries)
    checkout.scan(coffee)
  end

  it "adds each scanned item to basket for checkout" do
    expect(checkout.items).to include(green_tea, strawberries, coffee)
  end

  it "calculates total price correctly with rules applied" do
    expect(checkout.total).to eq(3.11 + 5.00 + 11.23)
  end
end
