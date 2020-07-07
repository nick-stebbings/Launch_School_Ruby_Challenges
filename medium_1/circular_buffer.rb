class CircularBuffer
  def initialize(length)
    @buffer_length = length
    clear
  end
  
  def clear
    @q = Array.new(@buffer_length, nil)
    @front = @rear = -1 # Pointers set to neutral
  end
  
  def read
    raise BufferEmptyException.new if is_empty?
    element = q[front]
    q[front] = nil
    @front = next_index(front)
    element
  end
  
  def write(obj)
    raise BufferFullException if is_full?
    if is_empty?                    
      @front = @rear = 0 # Set the pointers to the insertion point                           
    else                                   
      @rear = next_index(rear)      
    end                               
    q[rear] = obj                    
  end
  
  def write!(obj)
    return obj if obj.nil?         
    read if is_full?  
    write(obj)                                                   
  end
  
  private
  attr_reader :q, :front, :rear
  
  def next_index(idx)
    (idx + 1) % @buffer_length
  end

  def is_full?
    q.all?
  end

  def is_empty?
    q.none?
  end

  class BufferEmptyException < StandardError ; end
  class BufferFullException < StandardError ; end
end