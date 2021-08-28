# frozen_string_literal: true

require_relative '../../config/db'

module Admin
  # DashboardController Controller
  class DashboardController
    def index
      [
        200,
        { 'Content-Type' => 'text/html' },
        [index_body]
      ]
    end

    private

    def index_body
      @books = DB.new.connection.exec('SELECT * FROM books')

      ERB.new(File.read('app/views/admin/dashboard/index.html.erb')).result(binding)
    end
  end
end
