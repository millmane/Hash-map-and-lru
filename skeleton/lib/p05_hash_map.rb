require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end
  #
  # def inspect
  # end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    resize! if count == num_buckets

    if bucket(key).include?(key)
      bucket(key).each do |link|
        if link.key == key
          link.val = val
          break
        end
      end
    else
      bucket(key).insert(key, val)
      @count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each
    @store.each do |linked_list|
      linked_list.each { |link| yield(link.key, link.val) }
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    pairs = []

    each { |key, val| pairs << [key, val] }

    @store = Array.new(num_buckets * 2) { LinkedList.new }
    @count = 0

    pairs.each { |pair| set(*pair) }
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
