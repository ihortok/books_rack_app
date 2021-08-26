# frozen_string_literal: true

require_relative '../config/db'

# Books Controller
class SessionController
  def new
    [
      200,
      { 'Content-Type' => 'text/html' },
      new_body
    ]
  end

  def create(params:)
    # TODO: implement session creation
    [
      200,
      { 'Content-Type' => 'text/html' },
      [params.to_json]
    ]
  end

  private

  def new_body
    body = []

    File.open('app/views/session/new.html').each { |line| body << line }

    body
  end
end
