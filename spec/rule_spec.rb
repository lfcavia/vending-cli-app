require_relative '../lib/rule'
require_relative '../lib/product'

RSpec.describe Rule do
  let(:rule) { Rule.new }
  let(:green_tea) { Product.new('GR1', 'Green Tea', 3.11) }
  let(:strawberries) { Product.new('SR1', 'Strawberries', 5.00) }
  let(:coffee) { Product.new('CF1', 'Coffee', 11.23) }

  context "when applying green tea rule" do
    it "applies buy-one-get-one-free on green tea" do
      expect(rule.buy_one_get_one_free([green_tea, green_tea])).to eq(3.11)
    end
  end

  context "when applying strawberries rule" do
    it "applies bulk discount on strawberries" do
      expect(rule.minus_50_cents([strawberries, strawberries, strawberries])).to eq(13.5)
    end
  end

  context "when applying coffee rule" do
    it "applies discount when buying three or more coffees" do
      expect(rule.drops_to_two_thirds([coffee, coffee, coffee])).to eq(22.46)
    end
  end
end
