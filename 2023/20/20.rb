# frozen_string_literal: true

require_relative 'router'
require_relative 'button'

spec = File.open('input').read
           .split("\n")
           .map { |s| s.split(' -> ').map.with_index { |p, i| i == 1 ? p.split(', ') : p } }

router = Router.new
button = Button.new(router)
spec.map(&:first).each { |s| router.add(s) }
spec.each { |s| router.set_targets(s) }

1000.times do
  button.push
end
p router.counts.values.reduce(&:*)

button.push until router.cycle_lengths.size == 4

p router.cycle_lengths.values.reduce(1) { |acc, n| acc.lcm(n) }
