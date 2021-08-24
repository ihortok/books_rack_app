# frozen_string_literal: true

Dir[File.join(__dir__, 'controllers', '*.rb')].each { |file| require_relative file }

# Router
class Router
  def initialize(env)
    @path = env['PATH_INFO']
  end

  def call
    case @path
    when '/'
      HomeController.new.index
    else
      [404, { 'Contend-Type' => 'text/plain' }, ['404 Not Found']]
    end
  end
end
