# frozen_string_literal: true

# Flip-flop modules (prefix %) are either on or off; they are initially off.
# If a flip-flop module receives a high pulse, it is ignored and nothing happens.
# However, if a flip-flop module receives a low pulse, it flips between on and off.
# If it was off, it turns on and sends a high pulse.
# If it was on, it turns off and sends a low pulse.
class FlipFlop
  attr_reader :id
  attr_writer :targets

  def initialize(tag, router)
    @id = tag[1..]
    @router = router
    @pulse_types = %w[lo hi].cycle
    @pulse_type = @pulse_types.next
  end

  def receive(_sender, type)
    return unless type == 'lo'

    pulse
  end

  private

  def pulse
    toggle_pulse_type
    @targets.each do |target|
      @router.receive(@id, @pulse_type, target)
    end
  end

  def toggle_pulse_type
    @pulse_type = @pulse_types.next
  end
end
