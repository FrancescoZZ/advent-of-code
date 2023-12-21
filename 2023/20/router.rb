# frozen_string_literal: true

require_relative 'factory'

# Routes pulses between different modules
class Router
  attr_reader :counts, :cycle_lengths

  def initialize
    @modules = {}
    @queue = []
    @counts = Hash.new(0)
    @presses = 0
    @cycle_lengths = {}
  end

  def add(tag)
    new = Factory.create(tag, self)
    @modules[new.id] = new
  end

  def set_targets((tag, targets))
    id = tag.gsub(/[%&]/, '')
    @modules[id].targets = targets

    targets.select { |t| @modules[t].instance_of?(Conjunction) }
           .each { |t| @modules[t].add_input(@modules[id]) }
  end

  def receive(tag, type, target)
    @counts[type] += 1
    @queue << [tag, type, target]
  end

  def route
    @presses += 1
    while @queue.any?
      (sender, type, target) = @queue.shift
      @cycle_lengths[sender] = @presses if %w[lx db qz sd].member?(sender) && type == 'lo' && !@cycle_lengths[sender]
      @modules[target]&.receive(sender, type)
    end
  end
end
