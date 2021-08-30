# frozen_string_literal: true

require_relative '../config/db'

# Books Controller
class BooksController < BaseController
  def index
    headers = { 'Content-Type' => 'text/html' }

    [
      200,
      headers,
      [index_body]
    ]
  end

  private

  def index_body
    books = DB.new.connection.exec('SELECT * FROM books')
    books_json = {}

    books.each do |book|
      books_json[book['id']] = {
        name: book['name'],
        author: book['author']
      }
    end

    books_json.to_json
  end
end
