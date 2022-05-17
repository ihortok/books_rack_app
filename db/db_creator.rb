# frozen_string_literal: true

require 'sqlite3'

# Creates a database
class DBCreator
  def call
    p 'DB is already created' and return if File.exist?("#{ENV['APP_FULL_PATH']}/db/books.db")

    SQLite3::Database.new 'db/books.db'
  end
end
