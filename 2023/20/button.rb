# frozen_string_literal: true

# When you push the button, a single low pulse is sent directly to the broadcaster module.
class Button
  attr_reader :id, :count

  def initialize(router)
    @id = 'button'
    @router = router
  end

  def push
    @router.receive(@id, 'lo', 'broadcaster')
    @router.route
  end
end
