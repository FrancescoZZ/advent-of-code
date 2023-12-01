# frozen_string_literal: true

require_relative 'clock'

clock = Clock.new

instructions = File.open('input').read
instructions.split("\n")
            .map { |inst| inst.split(' ').each_with_index.map { |e, idx| idx == 1 ? e.to_i : e } }
            .each { |i| i[0] == 'addx' ? clock.add(i[1]) : clock.noop }

puts clock.signal_strengths
