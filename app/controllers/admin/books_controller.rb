# frozen_string_literal: true

require "#{ENV['APP_FULL_PATH']}/config/db"
require "#{ENV['APP_FULL_PATH']}/controllers/admin/base_controller"

module Admin
  # DashboardController
  class BooksController < Admin::BaseController
    def index
      return redirect_to_sign_in unless user_authenticated?

      [
        200,
        { 'Content-Type' => 'text/html' },
        index_body
      ]
    end

    def new
      return redirect_to_sign_in unless user_authenticated?

      [
        200,
        { 'Content-Type' => 'text/html' },
        new_body
      ]
    end

    def create(params:)
      return redirect_to_sign_in unless user_authenticated?

      db = DB.new.connection

      book_sql = %{
        INSERT INTO books (name, author)
        VALUES('#{params['book_name']}', '#{params['author']}')
      }

      db.exec(book_sql)

      [
        301,
        { 'Location' => '/admin/books' },
        []
      ]
    end

    def delete(params:)
      return redirect_to_sign_in unless user_authenticated?

      db = DB.new.connection

      book_sql = %{
        DELETE FROM books
        WHERE id = #{params['book_id']}
      }

      db.exec(book_sql)

      [
        301,
        { 'Location' => '/admin/books' },
        []
      ]
    end

    private

    def index_body
      @books = DB.new.connection.exec('SELECT * FROM books')

      @header_partial = ERB.new(File.read('app/views/admin/_header.html.erb')).result(binding)

      [ERB.new(File.read('app/views/admin/books/index.html.erb')).result(binding)]
    end

    def new_body
      @header_partial = ERB.new(File.read('app/views/admin/_header.html.erb')).result(binding)

      [ERB.new(File.read('app/views/admin/books/new.html.erb')).result(binding)]
    end
  end
end
