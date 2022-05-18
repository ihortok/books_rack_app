# frozen_string_literal: true

require_relative 'base_controller'

# Books Controller
class BooksController < BaseController
  def index
    [
      200,
      { 'Content-Type' => 'application/json' },
      [db.execute('SELECT * FROM books').to_json]
    ]
  end

  def create(params:)
    db.execute <<-SQL
      INSERT INTO books (name, author)
      VALUES("#{params['name']}", "#{params['author']}")
    SQL

    [
      201,
      { 'Content-Type' => 'text/plain' },
      ["#{params['name']} was created"]
    ]
  end
end
