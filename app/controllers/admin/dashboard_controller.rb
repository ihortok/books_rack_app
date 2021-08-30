# frozen_string_literal: true

require_relative '../../config/db'
require_relative 'base_controller'

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

      @header_partial = ERB.new(File.read('app/views/admin/dashboard/_header.html.erb')).result(binding)

      [ERB.new(File.read('app/views/admin/dashboard/index.html.erb')).result(binding)]
    end
  end
end
