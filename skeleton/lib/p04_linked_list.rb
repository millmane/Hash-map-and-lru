class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def self.generate_sentinels
    sent_head = Link.new
    sent_tail = Link.new

    sent_head.next = sent_tail
    sent_tail.prev = sent_head

    [sent_head, sent_tail]
  end


  def initialize
    @sent_head, @sent_tail = LinkedList.generate_sentinels
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @sent_head.next
  end

  def last
    @sent_tail.prev
  end

  def empty?
    # shouldn't be necessary to check both, but good for debugging
    first == @sent_tail && last == @sent_head
  end

  def get(key)
    each do |link|
      return link.val if link.key == key
    end
    nil
  end

  def include?(key)
    any? { |link| link.key == key }
  end

  def insert(key, val)
    new_link = Link.new(key, val)

    new_link.prev = last
    new_link.next = @sent_tail

    last.next = new_link
    @sent_tail.prev = new_link
  end

  def remove(key)
    each do |link|
      if link.key == key
        link.prev.next = link.next
        link.next.prev = link.prev
        break
      end
    end
    nil
  end

  def each
    current_link = @sent_head.next

    until current_link.next.nil?
      yield(current_link)
      current_link = current_link.next
    end

    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
