# frozen_string_literal: true

require 'sqlite3'
require "#{ENV['APP_FULL_PATH']}/config/database"

# Makes changes to a database
class DBMigrator
  def call
    p 'DB does not exist, run `rake db:create`' and return unless File.exist?("#{ENV['APP_FULL_PATH']}/db/books.db")

    create_versions
    create_books
  end

  private

  def db
    @db ||= Database.new.connection
  end

  def last_version_num
    db.execute('SELECT num FROM versions ORDER BY ID DESC LIMIT 1').first&.dig('num').to_i
  end

  def create_versions
    db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS versions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        num int NOT NULL UNIQUE
      );
    SQL
  end

  def create_books
    return if last_version_num >= 1_652_737_549_511

    db.execute <<-SQL
      CREATE TABLE books (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(100),
        author VARCHAR(100)
      );
    SQL

    db.execute <<-SQL
      INSERT INTO versions (num)
      VALUES (1652737549511)
    SQL
  end
end
