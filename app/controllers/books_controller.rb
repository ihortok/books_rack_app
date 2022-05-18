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

  def create(params)
    db.execute <<-SQL
      INSERT INTO books (name, author)
      VALUES("#{params['name']}", "#{params['author']}")
    SQL

    book_created_redirect(db.last_insert_row_id)
  end

  def show(id)
    books = db.execute <<-SQL
      SELECT * FROM books
      WHERE id = #{id}
    SQL

    return not_found if books.empty?

    [
      200,
      { 'Content-Type' => 'application/json' },
      [books.first.to_json]
    ]
  end

  private

  def book_created_redirect(id)
    [
      301,
      {
        'http-equiv' => 'refresh',
        'content' => "/books/#{id}"
      },
      []
    ]
  end
end
