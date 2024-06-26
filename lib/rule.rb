# To apply these pricing rules to another product:
# - Replace product code (p.e. 'GR1') with the desired product code in the item.code comparison.
class Rule
  def buy_one_get_one_free(items)
    items_filtered = items.select { |item| item.code == 'GR1' }
    count = items_filtered.count
    if count > 0
      price_per_item = items_filtered.first.price
      free_items = count / 2
      (count - free_items) * price_per_item
    else
      0
    end
  end

  def minus_50_cents(items)
    items_filtered = items.select { |item| item.code == 'SR1' }
    count = items_filtered.count
    if count > 0
      price_per_item = items_filtered.first.price
      price_per_item -= 0.50 if count >= 3
      count * price_per_item
    else
      0
    end
  end

  def drops_to_two_thirds(items)
    items_filtered = items.select { |item| item.code == 'CF1' }
    count = items_filtered.count
    if count > 0
      price_per_item = items_filtered.first.price
      price_per_item *= 2 / 3.0 if count >= 3
      count * price_per_item
    else
      0
    end
  end
end
