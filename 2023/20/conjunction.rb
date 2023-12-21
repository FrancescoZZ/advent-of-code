# frozen_string_literal: true

# Conjunction modules (prefix &) remember the type of the most recent pulse
# received from each of their connected input modules;
# they initially default to remembering a low pulse for each input.
# When a pulse is received, the conjunction module first updates its memory for that input.
# Then, if it remembers high pulses for all inputs, it sends a low pulse;
# otherwise, it sends a high pulse.
class Conjunction
  attr_reader :id, :state
  attr_writer :targets

  def initialize(tag, router)
    @id = tag[1..]
    @router = router
    @state = {}
    @pulse_type = 'hi'
  end

  def add_input(input)
    @state[input.id] = 'lo'
  end

  def receive(sender, type)
    @state[sender] = type
    pulse
  end

  private

  def pulse
    set_pulse_type
    @targets.each do |target|
      @router.receive(@id, @pulse_type, target)
    end
  end

  def set_pulse_type
    @pulse_type = @state.values.all?('hi') ? 'lo' : 'hi'
  end
end
