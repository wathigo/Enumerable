# frozen_string_literal: true

require File.expand_path('./main')

describe Enumerable do
  let(:items1) { [0, 5, 7, 9] }
  let(:items2) { %w[thin den] }
  let(:result) { [] }
  item = ->(val) { val > 5 }
  describe '#my each' do
    context 'When a block is not given' do
      it 'Returns an enumerable object' do
        expect(items1.my_each.is_a?(Enumerable)).to eql(true)
      end
    end

    context 'When a block is given' do
      it 'Executes the block for each of the iteratable items' do
        items2.my_each { |value| result.push(value) }
        expect(result).to eql(items2)
      end
    end
  end

  describe '#my_each_with_index' do
    context 'When a block is not given' do
      it 'Returns an Enumerable object' do
        expect(items1.my_each_with_index.is_a?(Enumerable)).to eql(true)
      end
    end

    context 'When a block is not given' do
      it "Executes the block give on every item in the specific index \
          of the iteratable" do
        result = []
        items2.my_each_with_index do |value, index|
          result.push("#{value}:\
           #{index}")
        end
        expect(result).to eql(['thin: 0', 'den: 1'])
      end
    end
  end

  describe '#my_select' do
    context 'When a block is not given' do
      it 'Returns an enumerable object' do
        expect(items1.my_select.is_a?(Enumerable)).to eql(true)
      end
    end

    context 'When a block is given' do
      it "Returns an array of elements containing the items that \
          returns true when passed as a parameter to the block" do
        expect(items1.my_select(&item)).to eql([7, 9])
      end
    end
  end

  describe '#my_all?' do
    context 'When a block is not given' do
      it 'Returns false if one of the object elements is false or nil' do
        items2.push(false)
        expect(items2.my_all?).to eql(false)
      end
    end

    context 'When a block is given' do
      it 'Returns false if the block return false or nil' do
        expect(items1.my_all?(&item)).to eql(false)
      end
      it 'Returns true if a block never returns false or nil' do
        expect(items1.my_all? { |value| value.is_a? Integer }).to eql(true)
      end
    end
  end

  describe '#my_any?' do
    context 'When a block is not given' do
      it "Returns true if one or more of the values in the iteratable \
          is not false or nil" do
        expect(items2.my_any?).to eql(true)
      end
    end

    context 'Whan a block is given' do
      it "Returns true if the block ever returns a value other than \
          alse or nil" do
        expect(items1.my_any?(&item)).to eql(true)
      end
    end
  end

  describe '#my_none?' do
    let(:lie) { [nil, false] }
    context 'When a block is not given' do
      it "Returns false if one or more elements in the iteratable \
          is true" do
        expect(items2.my_none?).to eql(false)
      end
      it 'Returns true if none of the iteratable elements is true' do
        expect(lie.my_none?).to eql(true)
      end
    end

    context 'Whan a block is given' do
      it 'Returns true when the block never returns true' do
        expect(items1.my_none? { |value| value.is_a? String }).to eql(true)
      end
      it 'Returns false if a block ever returns true' do
        expect(items1.my_none?(&item)).to eql(false)
      end
    end
  end

  describe '#my_count' do
    it 'Returns the length on an iteratable' do
      expect(items2.my_count).to eql(2)
    end
  end

  describe '#my_map' do
    it 'Returns an array containing boolean values returned by the block' do
      expect(items1.my_map(&item)).to eql([false, false, true, true])
    end
  end

  describe '#my_inject' do
    let (:items3) { [1, 4, 6] }
    it 'Returns the product of the individual values in an array' do
      prod = multiply_els(items3)
      expect(prod).to eql(24)
    end
  end
end
