# frozen_string_literal: true

# Performs noop and add
class Clock
  attr_reader :signal_strengths

  def initialize
    @x = 1
    @cycle = 0
    @signal_strengths = 0
    @pixel_idx = 0
  end

  def noop
    tick
  end

  def add(num)
    2.times { tick }
    @x += num
  end

  private

  def draw
    pixel = @pixel_idx.between?(@x - 1, @x + 1) ? '#' : '.'
    print pixel
    print "\n" if @pixel_idx == 39

    @pixel_idx = (@pixel_idx + 1) % 40
  end

  def tick
    @cycle += 1
    draw
    return unless ((@cycle - 20) % 40).zero?

    @signal_strengths += signal_strength
  end

  def signal_strength
    @cycle * @x
  end
end
