class Element
  attr_accessor :datum, :next

  def initialize(datum, next_node = nil)
    @datum = datum
    @next = next_node
  end

  def tail?
    !!@next.nil?
  end

  def nil?
    datum.nil?
  end
end

class SimpleLinkedList
  attr_reader :head

  def initialize(datum = nil, *data)
    @head = Element.new(datum)
    data.each { |d| self.push(d) } if data
  end
  
  def empty?
    head.datum.nil?
  end

  def tail?
    head.tail?
  end
 
  def peek
    head.datum
  end
  
  alias_method :datum, :peek

  def push(obj)
    @head = head ? Element.new(obj, head) : Element.new(obj)
  end

  def pop
    current = head.datum
    @head = head.next
    current
  end

  def to_a
    return [] if empty?
    arr = [head.datum]
    current = head
    while current.next
      current = current.next
      arr << current.datum
    end
    arr
  end

  def size
    return 0 if head.nil?
    counter = 1
    current = head
    until current.next.nil?
      current = current.next
      counter += 1
    end
    counter
  end

  def reverse
    SimpleLinkedList.new(*to_a)
  end
  
  class << self
    def from_a(arr)
      arr.nil? ? SimpleLinkedList.new(nil) : new(*arr.reverse)
    end

    def size_recursive(head)
      length = head.nil? ? 0 : 1
      length > 0 ? length + size_recursive(head.next) : length
    end
  end
end