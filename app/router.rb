# frozen_string_literal: true

require 'json'

Dir[File.join(__dir__, 'controllers', '*.rb')].each { |file| require_relative file }
Dir[File.join(__dir__, 'controllers/*', '*.rb')].each { |file| require_relative file }

# Router
class Router
  def initialize(env)
    @env = env
    @path = env['PATH_INFO']
    @method = env['REQUEST_METHOD']
  end

  def call
    if @path == '/'
      HomeController.new(@env).index
    elsif @path == '/books'
      BooksController.new(@env).index

    # Sessions
    elsif @method == 'GET' && @path == '/session/new'
      SessionController.new(@env).new
    elsif @method == 'POST' && @path == '/session/create'
      SessionController.new(@env).create(params: Rack::Utils.parse_query(@env['rack.input'].gets))
    elsif @method == 'POST' && @path == '/session/delete'
      SessionController.new(@env).delete

    # Admin
    elsif @method == 'GET' && @path == '/admin/dashboard'
      Admin::DashboardController.new(@env).index

    elsif @method == 'GET' && @path == '/admin/books'
      Admin::BooksController.new(@env).index
    elsif @method == 'GET' && @path == '/admin/books/new'
      Admin::BooksController.new(@env).new
    elsif @method == 'POST' && @path == '/admin/books/create'
      Admin::BooksController.new(@env).create(params: Rack::Utils.parse_query(@env['rack.input'].gets))
    elsif @method == 'POST' && @path == '/admin/books/delete'
      Admin::BooksController.new(@env).delete(params: Rack::Utils.parse_query(@env['rack.input'].gets))

    elsif @method == 'GET' && @path == '/admin/users'
      Admin::UsersController.new(@env).index
    elsif @method == 'GET' && @path == '/admin/users/new'
      Admin::UsersController.new(@env).new
    elsif @method == 'POST' && @path == '/admin/users/create'
      Admin::UsersController.new(@env).create(params: Rack::Utils.parse_query(@env['rack.input'].gets))
    elsif @method == 'POST' && @path == '/admin/users/delete'
      Admin::UsersController.new(@env).delete(params: Rack::Utils.parse_query(@env['rack.input'].gets))

    else
      [404, { 'Content-Type' => 'text/plain' }, ['404 Not Found']]
    end
  end
end
