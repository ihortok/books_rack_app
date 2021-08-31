# frozen_string_literal: true

require "#{ENV['APP_FULL_PATH']}/config/db"
require "#{ENV['APP_FULL_PATH']}/controllers/admin/base_controller"

module Admin
  # DashboardController
  class UsersController < Admin::BaseController
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

      user_sql = %{
        INSERT INTO users (first_name, last_name, email, password, admin)
        VALUES('#{params['first_name']}', '#{params['last_name']}', '#{params['email']}',
          '#{params['password']}', '#{params['admin']}')
      }

      db.exec(user_sql)

      [
        301,
        { 'Location' => '/admin/users' },
        []
      ]
    end

    def delete(params:)
      return redirect_to_sign_in unless user_authenticated?

      db = DB.new.connection

      user_sql = %{
        DELETE FROM users
        WHERE id = #{params['user_id']}
      }

      db.exec(user_sql)

      [
        301,
        { 'Location' => '/admin/users' },
        []
      ]
    end

    private

    def index_body
      @users = DB.new.connection.exec('SELECT * FROM users')

      @header_partial = ERB.new(File.read('app/views/admin/_header.html.erb')).result(binding)

      [ERB.new(File.read('app/views/admin/users/index.html.erb')).result(binding)]
    end

    def new_body
      @header_partial = ERB.new(File.read('app/views/admin/_header.html.erb')).result(binding)

      [ERB.new(File.read('app/views/admin/users/new.html.erb')).result(binding)]
    end
  end
end
