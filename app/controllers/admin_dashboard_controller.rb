# frozen_string_literal: true

require_relative '../config/db'

# Books Controller
class AdminController
  def index
    [
      200,
      { 'Content-Type' => 'text/plain' },
      [index_body]
    ]
  end

  private

  def index_body
    ''
  end
end
