# frozen_string_literal: true

require 'json'

Dir[File.join(ENV['APP_FULL_PATH'], 'app/controllers/', '*.rb')].sort.each { |file| require_relative file }

# Router
class Router
  def initialize(env)
    @env = env
    @request = Rack::Request.new(env)
  end

  # rubocop:disable Metrics
  def call
    # home
    if request.get? && request.path == '/'
      HomeController.new(env).index

    # books
    elsif request.get? && ['/books', '/books/'].include?(request.path)
      BooksController.new(env).index
    elsif request.get? && %r{^(/books/)\d+$}.match?(request.path)
      BooksController.new(env).show(request.path.split('/').last)
    elsif request.post? && request.path == '/books'
      BooksController.new(env).create(request.params)

    # not found
    else
      [404, { 'content-type' => 'text/plain' }, ['404 Not Found']]
    end
  end
  # rubocop:enable Metrics

  private

  attr_reader :env, :request
end
