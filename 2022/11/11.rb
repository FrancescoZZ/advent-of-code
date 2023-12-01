# frozen_string_literal: true

require_relative 'monkey'

monkey_instructions = File.open('input')
                          .read
                          .split("\n\n")

monkeys = []

monkey_instructions.each do |i|
  _id, items, op, test, id_true, id_false = i.split("\n")

  items = items.split(': ').last.split(', ').map(&:to_i)
  op = op.split.last(2)
  test = test.split.last.to_i
  id_true = id_true.split.last.to_i
  id_false = id_false.split.last.to_i
  monkeys << Monkey.new(items, op, test, id_true, id_false)
end

lcm = monkeys.map(&:div).reduce(:*)

10_000.times do
  monkeys.each do |m|
    m.items.length.times do
      new_val = m.inspect % lcm
      new_id = m.test(new_val)
      monkeys[new_id].add(new_val)
    end
  end
end

monkey_business = monkeys.map(&:inspected_count)
                         .sort
                         .last(2)
                         .reduce(:*)

p monkey_business
