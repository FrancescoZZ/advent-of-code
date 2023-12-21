# frozen_string_literal: true

# There is a single broadcast module (named broadcaster).
# When it receives a pulse, it sends the same pulse to all of its destination modules.
class Broadcaster
  attr_reader :id
  attr_writer :targets

  def initialize(tag, router)
    @id = tag
    @router = router
  end

  def receive(_sender, type)
    @targets.each do |target|
      @router.receive(@id, type, target)
    end
  end
end
