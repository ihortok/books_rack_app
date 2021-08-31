# frozen_string_literal: true

require "#{ENV['APP_FULL_PATH']}/config/db"
require "#{ENV['APP_FULL_PATH']}/controllers/admin/base_controller"

module Admin
  # DashboardController
  class DashboardController < Admin::BaseController
    def index
      return redirect_to_sign_in unless user_authenticated?

      [
        200,
        { 'Content-Type' => 'text/html' },
        index_body
      ]
    end

    private

    def index_body
      @books = DB.new.connection.exec('SELECT * FROM books')
      @users = DB.new.connection.exec('SELECT * FROM users')

      @header_partial = ERB.new(File.read('app/views/admin/_header.html.erb')).result(binding)

      [ERB.new(File.read('app/views/admin/dashboard/index.html.erb')).result(binding)]
    end
  end
end
