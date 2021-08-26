# frozen_string_literal: true

require 'json'

Dir[File.join(__dir__, 'controllers', '*.rb')].each { |file| require_relative file }

# Router
class Router
  def initialize(env)
    @path = env['PATH_INFO']
    @method = env['REQUEST_METHOD']
  end

  def call
    if @path == '/'
      HomeController.new.index
    elsif @path == '/books'
      BooksController.new.index
    elsif @path == '/admin'
      SessionController.new.new
    elsif @path == '/admin/sign_in' && @method == 'POST'
      SessionController.new.create
    else
      [404, { 'Content-Type' => 'text/plain' }, ['404 Not Found']]
    end
  end
end
