# frozen_string_literal: true

require_relative 'base_controller'

# Books Controller
class BooksController < BaseController
  def index
    @books = db.execute('SELECT * FROM books')

    [
      200,
      { 'Content-Type' => 'text/html' },
      [ERB.new(File.read('app/views/books/index.html.erb')).result(binding)]
    ]
  end

  def show(id)
    books = db.execute <<-SQL
      SELECT * FROM books
      WHERE id = #{id}
    SQL

    return not_found if books.empty?

    @book = books.first

    [
      200,
      { 'Content-Type' => 'text/html' },
      [ERB.new(File.read('app/views/books/show.html.erb')).result(binding)]
    ]
  end

  def create(params)
    db.execute <<-SQL
      INSERT INTO books (name, author)
      VALUES("#{params['name']}", "#{params['author']}")
    SQL

    book_created_redirect(db.last_insert_row_id)
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
