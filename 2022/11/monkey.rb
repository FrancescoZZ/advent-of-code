# frozen_string_literal: true

# Monnkey.new(id, items, operation, test, id_true, id_false)
class Monkey
  attr_reader :items, :inspected_count, :div

  def initialize(items, operation, div, id_true, id_false)
    @items = items
    @operation = operation
    @div = div
    @id_true = id_true
    @id_false = id_false
    @inspected_count = 0
  end

  def inspect
    old = @items.shift
    operator = @operation.first
    operand = @operation.last.eql?('old') ? old : @operation.last.to_i
    @inspected_count += 1
    # old.public_send(operator, operand) / 3
    old.public_send(operator, operand)
  end

  def test(val)
    (val % @div).zero? ? @id_true : @id_false
  end

  def add(item)
    @items.push(item)
  end
end
