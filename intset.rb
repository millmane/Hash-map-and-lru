class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(int)
    @store[int] = true
  end

  def remove(int)
    @store[int] = false
  end

  def include?(int)
    @store[int]
  end
end

class IntSet
  def initialize
    @length = 20
    @store = Array.new(@length) { [] }
  end

  def insert(int)
    @store[int % @length] << int
  end

  def remove(int)
    @store[int % @length].delete(int)
  end

  def include?(int)
    @store[int % @length].include?(int)
  end
end
