# frozen_string_literal: true

require_relative '../config/db'

# Books Controller
class SessionController
  def new
    [
      200,
      { 'Content-Type' => 'text/html' },
      [File.open('app/views/session/index.html').read],
      new_body
    ]
  end

  def create
    raise 'Implement me!'
  end

  private

  def new_body
    body = []

    File.open('app/views/session/index.html').each { |line| body << line }

    body
  end
end
