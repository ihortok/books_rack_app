# frozen_string_literal: true

require 'bcrypt'
require 'securerandom'
require_relative '../config/db'

# Books Controller
class SessionController < BaseController
  def new
    return new_redirect if user_authenticated?

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
    headers = { 'Location' => '/admin/dashboard' }

    Rack::Utils.set_cookie_header!(headers, 'session_key', { value: key, path: '/' })
    Rack::Utils.set_cookie_header!(headers, 'user_id', { value: user['id'], path: '/' })

    session_sql = %{
      INSERT INTO sessions (key, user_id, start_at, terminate_at)
      VALUES('#{BCrypt::Password.create(key)}', '#{user['id']}', '#{Time.now.utc}', '#{Time.now.utc + 3600 * 3}')
    }

    db.exec(session_sql)

    [
      301,
      headers,
      []
    ]
  end

  def delete
    headers = { 'Location' => '/' }

    Rack::Utils.delete_cookie_header!(headers, 'user_id', { value: '', path: '/' })
    Rack::Utils.delete_cookie_header!(headers, 'session_key', { value: '', path: '/' })

    [
      301,
      headers,
      []
    ]
  end

  private

  def new_body
    [ERB.new(File.read('app/views/session/new.html.erb')).result(binding)]
  end

  def new_redirect
    [
      301,
      { 'Location' => '/admin/dashboard' },
      []
    ]
  end
end
