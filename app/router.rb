# frozen_string_literal: true

require 'json'

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
    when '/books'
      BooksController.new.index
    else
      [404, { 'Content-Type' => 'text/plain' }, ['404 Not Found']]
    end
  end
end
