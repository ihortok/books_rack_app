# frozen_string_literal: true

require 'pg'

# Database
class DB
  attr_reader :connection

  def initialize
    @connection = PG::Connection.new(
      host: ENV['DB_HOST'],
      port: ENV['DB_PORT'],
      dbname: ENV['DB_NAME'],
      user: ENV['DB_USER'],
      password: ENV['DB_PASSWORD']
    )
  end
end
