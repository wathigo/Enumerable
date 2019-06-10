module Enumerable
  def my_each
    for i in 0...self.length
      yield(self[i])
    end
  end

  def my_each_with_index
    for i in 0...self.length
      yield(i, self[i])
    end
  end

  def my_select
    items = []
    for i in 0...self.length
      item = yield(self[i])
      items.append(self[i]) if item
    end
    items
  end

  def my_all?
    return true if self == []
    for i in 0...self.length
      truth = yield(self[i])
      return truth if truth == false
    end
    truth
  end

  def my_any?
    truth = false
    for i in 0...self.length
      truth = yield(self[i])
      return true if truth == true
    end
    truth
  end

  def my_none?
    return true if self == []
    for i in 0...self.length
      truth = yield(self[i])
      return false if truth == true
    end
    true
  end

  def my_count
    self.length
  end

  def my_map
    new_array = []
    for i in 0...self.length
      val = yield(self[i])
      new_array.append(val)
    end
    new_array
  end

  def my_inject
    initial_val = 1
    for i in 0...self.length
      initial_val = yield(initial_val, self[i])
    end
    initial_val
  end
end

# *** test for my_each ***
result = %w[den soft filter delter].my_each{|item| print "item: #{item}"}
#=> item: den,item: softitem: filter,item: delter

# *** test for my_each_with_index ***
print "\n"
result = [4, 5, 8, 20].my_each_with_index {|index, value| print "#{index}: #{value}  "}
print "\n"
#=> 0: 4  1: 5  2: 8  3: 20

# *** test for my_select ***
result = [2, 8, 4, 9, 5, 7, 4].my_select {|value| value > 5}
print "#{result}"
print "\n"
#=> [8, 9, 7]

# *** test for my_all ***
result = [4, 6, 1, 8].my_all? {|val| val > 1}
print result
print "\n"
#=> false

#*** test for my_any ***
result = %w[life death immortal clean].my_any? {|val| val.length > 9}
print result
print "\n"
#=> false

# *** test for my_none ***
result = [4, 6, 1, 8].my_none? {|val| val < 1}
print result
print "\n"
#=> true

# *** test for my_count ***
result = [4, 6, 1, 8].my_count
print result
print "\n"
#=> 4


# *** test my_inject ***
def multiply_els(arr)
  arr.my_inject {|prod, val|
         prod * val}
end
puts multiply_els([2,4,5])
#=> 40

# **** test my_map using proc****
item = -> (val) {val > 5}
result = [2, 8, 4, 9, 5, 7, 4].my_map(&item)
puts "new_array: #{result}"
#=> new_array: [false, true, false, true, false, true, false]