class Element
  attr_accessor :datum, :next

  def initialize(datum, next_node = nil)
    @datum = datum
    @next = next_node
  end

  def tail?
    @next.nil?
  end
end

class SimpleLinkedList
  attr_reader :head

  def initialize(datum = nil)
    @head = Element.new(datum)
  end

  def empty?
    head.datum.nil?
  end

  def peek
    head.datum
  end

  def push(obj)
    @head = Element.new(obj, @head)
  end

  def size
    return 0 if head.nil?

    counter = @head.datum.nil? ? 0 : 1
    current = nil
    until @next.nil?
      counter += 1
      current = @head.next
    end
    counter
  end

  def self.size_recursive(head)
    length = head.nil? || head.datum.nil? ? 0 : 1
    if length > 0
      length + size_recursive(head.next)
    else
      length
    end
  end
end

l = SimpleLinkedList.new(Element.new(2))
p l  # => #<SimpleLinkedList:0x00007fffd3b6a280 @head=#<Element:0x00007fffd3b6a258 @datum=#<Element:0x00007fffd3b6a2a8 @datum=2, @next=nil>, @next=nil>>
l.head.datum  # => #<Element:0x00007fffd3b6a2a8 @datum=2, @next=nil>
l.push(3)
l.head # => #<Element:0x00007fffd3b6a258 @datum=#<Element:0x00007fffd3b6a2a8 @datum=2, @next=nil>, @next=nil>
l.head.next.next # ~> NoMethodError: undefined method `next' for nil:NilClass
SimpleLinkedList.size_recursive(l.head)
SimpleLinkedList.size_recursive(SimpleLinkedList.new.head)

# >> #<SimpleLinkedList:0x00007fffd3b6a280 @head=#<Element:0x00007fffd3b6a258 @datum=#<Element:0x00007fffd3b6a2a8 @datum=2, @next=nil>, @next=nil>>

# ~> NoMethodError
# ~> undefined method `next' for nil:NilClass
# ~>
# ~> simple_linked_list.rb:58:in `<main>'

