# frozen_string_literal: true

# BaseController
class BaseController
  attr_reader :env

  def initialize(env)
    @env = env
  end
end
