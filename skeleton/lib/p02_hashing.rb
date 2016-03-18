require 'byebug'
class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    accum = 0

    each_with_index do | el, idx |
      accum += (el.hash ^ idx)
    end

    accum.hash
  end
end

class String
  def hash
    if length < 2
      return self.ord.hash.hash
    end

    chars.hash.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    to_a.sort.hash.hash
  end
end
