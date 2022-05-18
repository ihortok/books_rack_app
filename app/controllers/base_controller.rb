# frozen_string_literal: true

require "#{ENV['APP_FULL_PATH']}/config/database"

# Base Controller
class BaseController
  attr_reader :env, :db

  def initialize(env)
    @env = env
    @db = Database.new.connection
  end

  private

  def not_found
    [404, { 'Content-Type' => 'text/plain' }, ['404 Not Found']]
  end
end
