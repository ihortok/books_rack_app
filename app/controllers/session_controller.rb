# frozen_string_literal: true

require 'bcrypt'
require 'securerandom'
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
    db = DB.new.connection

    user = db.exec("SELECT * FROM users WHERE email = '#{params['email']}'").first

    return [401, {}, ['no user']] unless user

    return [401, {}, ['no user']] unless BCrypt::Password.new(user['password']) == params['password']

    key = SecureRandom.urlsafe_base64(10)
    headers = { 'Content-Type' => 'text/html' }

    Rack::Utils.set_cookie_header!(headers, 'session_key', { value: key, path: '/' })
    Rack::Utils.set_cookie_header!(headers, 'user_id', { value: user['id'], path: '/' })

    session_sql = %{
      INSERT INTO sessions (key, user_id, start_at, terminate_at)
      VALUES('#{BCrypt::Password.create(key)}', '#{user['id']}', '#{Time.now}', '#{Time.now + 3600 * 3}')
    }

    db.exec(session_sql)

    [
      200,
      headers,
      [params.to_json]
    ]
  end

  def delete
    headers = { 'Content-Type' => 'text/html', 'Location' => '/' }

    Rack::Utils.delete_cookie_header!(headers, 'user_id', { value: '', path: '/' })
    Rack::Utils.delete_cookie_header!(headers, 'session_key', { value: '', path: '/' })

    [
      200,
      headers,
      []
    ]
  end

  private

  def new_body
    [ERB.new(File.read('app/views/session/new.html.erb')).result(binding)]
  end
end
