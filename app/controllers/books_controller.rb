# frozen_string_literal: true

require "#{ENV['APP_FULL_PATH']}/config/database"
require_relative 'base_controller'

# Books Controller
class BooksController < BaseController
  def index
    headers = { 'Content-Type' => 'application/json' }

    [
      200,
      headers,
      [index_body]
    ]
  end

  private

  def index_body
    books = Database.new.connection.execute('SELECT * FROM books')
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
