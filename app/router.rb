# frozen_string_literal: true

require 'json'

Dir[File.join(__dir__, 'controllers', '*.rb')].each { |file| require_relative file }

# Router
class Router
  def initialize(env)
    @env = env
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
    elsif @method == 'GET' && @path == '/session/new'
      SessionController.new.new
    elsif @method == 'POST' && @path == '/session/create'
      SessionController.new.create(params: Rack::Utils.parse_query(@env['rack.input'].gets))
    elsif @path == '/admin/sign_in' && @method == 'POST'
      SessionController.new.create
    else
      [404, { 'Content-Type' => 'text/plain' }, ['404 Not Found']]
    end
  end
end
