class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      case item.name
      when 'Aged Brie'
        update_aged_brie(item)
      when 'Sulfuras, Hand of Ragnaros'
      when 'Backstage passes to a TAFKAL80ETC concert'
        update_backstage_passes(item)
      when 'Conjured Mana Cake'
        update_conjured_item(item)
      else
        update_normal_item(item)
      end
    end
  end

  private

  def update_aged_brie(item)
    item.sell_in -= 1
    item.quality += 1 if item.quality < 50
    item.quality += 1 if item.sell_in < 0 && item.quality < 50
  end

  def update_backstage_passes(item)
    item.sell_in -= 1
    if item.sell_in < 0
      item.quality = 0
    elsif item.sell_in <= 5
      item.quality += 3
    elsif item.sell_in <= 10
      item.quality += 2
    else
      item.quality += 1
    end
    item.quality = 50 if item.quality > 50
  end

  def update_conjured_item(item)
    item.sell_in -= 1
    item.quality -= 2 if item.quality > 0
    item.quality -= 2 if item.sell_in < 0 && item.quality > 0
  end

  def update_normal_item(item)
    item.sell_in -= 1
    item.quality -= 1 if item.quality > 0
    item.quality -= 2 if item.sell_in < 0 && item.quality > 0
    item.quality = 0 if item.quality.negative?
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
