# frozen_string_literal: true

require "#{ENV['APP_FULL_PATH']}/config/db"

# BaseController
class BaseController
  attr_reader :env

  def initialize(env)
    @env = env
  end

  private

  def user_authenticated?
    authentication_hash = Rack::Utils.parse_cookies(env).select { |key| %w[session_key user_id].include? key }

    return false unless authentication_hash.keys == %w[session_key user_id]

    session_sql = %{
      SELECT * FROM sessions
      WHERE user_id = #{authentication_hash['user_id']}
      AND terminate_at > '#{Time.now.utc}'
      ORDER BY terminate_at DESC
    }

    session = DB.new.connection.exec(session_sql).first

    return false unless session

    BCrypt::Password.new(session['key']) == authentication_hash['session_key']
  end

  def redirect_to_sign_in
    [
      301,
      { 'Location' => '/session/new' },
      []
    ]
  end
end
