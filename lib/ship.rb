class Ship
  attr_reader :name,
              :size,
              :hit_count

  def initialize(name, size)
    @name = name
    @size = size
    @hit_count = 0
  end

  def hit!
    @hit_count += 1
  end

  def sunk?
    @hit_count == @size
  end

end
