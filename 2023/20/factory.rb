# frozen_string_literal: true

require_relative 'conjunction'
require_relative 'flipflop'
require_relative 'broadcaster'

# Creates new modules
class Factory
  def self.create(tag, router)
    case tag[0]
    when '&' then Conjunction.new(tag, router)
    when '%' then FlipFlop.new(tag, router)
    else Broadcaster.new(tag, router)
    end
  end
end
