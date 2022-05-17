# frozen_string_literal: true

require 'sqlite3'

# Database
class Database
  attr_reader :connection

  def initialize
    @connection = SQLite3::Database.new "#{ENV['APP_FULL_PATH']}/db/books.db"
    @connection.results_as_hash = true
  end
end
