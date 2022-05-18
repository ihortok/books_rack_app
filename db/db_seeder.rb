# frozen_string_literal: true

require "#{ENV['APP_FULL_PATH']}/lib/database_seeds/main"

# Creates a database
class DBSeeder
  def call
    DatabaseSeeds::Main.execute
  end
end
