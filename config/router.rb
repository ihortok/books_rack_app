# frozen_string_literal: true

require 'json'

Dir[File.join(ENV['APP_FULL_PATH'], 'app/controllers/', '*.rb')].sort.each { |file| require_relative file }

# Router
class Router
  def initialize(env)
    @env = env
    @request = Rack::Request.new(env)
  end

  def call # rubocop:disable Metrics/AbcSize
    if request.get? && request.path == '/'
      HomeController.new(@env).index
    elsif request.get? && request.path == '/books'
      BooksController.new(@env).index
    elsif request.post? && request.path == '/books'
      BooksController.new(@env).create(params: request.params)
    else
      [404, { 'Content-Type' => 'text/plain' }, ['404 Not Found']]
    end
  end

  private

  attr_reader :env, :request
end
