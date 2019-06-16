# frozen_string_literal: true

module Enumerable
  # module that defines common enumerable methods
  def my_each
    if block_given?
      (0...length).each do |i|
        yield(self[i])
      end
    else
      to_enum(:my_each)
    end
  end

  def my_each_with_index
    if block_given?
      (0...length).each do |i|
        yield(self[i], i)
      end
    else
      to_enum(:my_each_with_index)
    end
  end

  def my_select
    items = []
    if block_given?
      (0...length).each do |i|
        item = yield(self[i])
        items.append(self[i]) if item
      end
    else
      to_enum(:my_select)
    end
    items
  end

  def my_all?
    return true if self == []

    truth = true
    if block_given?
      (0...length).each do |i|
        truth = yield(self[i])
        return truth if truth == false
      end
    else
      (0...length).each do |i|
        return false if self[i].nil? || self[i] == false
      end
      return true
    end
    truth
  end

  def my_any?
    truth = false
    if block_given?
      (0...length).each do |i|
        truth = yield(self[i])
        return true if truth == true
      end
    else
      (0...length).each do |i|
        return true if !self[i].nil? && self[i] != false
      end
    end
    truth
  end

  def my_none?
    return true if self == []
    if block_given?
      (0...length).each do |i|
        truth = yield(self[i])
        return false if truth == true
      end
    else
      (0...length).each do |i|
        return false if self[i] != false && !self[i].nil?
      end
    end
    true
  end

  def my_count
    length
  end

  def my_map
    new_array = []
    (0...length).each do |i|
      val = yield(self[i])
      new_array.append(val)
    end
    new_array
  end

  def my_inject
    initial_val = 1
    (0...length).each do |i|
      initial_val = yield(initial_val, self[i])
    end
    initial_val
  end
end

def multiply_els(arr)
  arr.my_inject do |prod, val|
    prod * val
  end
end
