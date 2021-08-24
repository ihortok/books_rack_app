# frozen_string_literal: true

require 'dotenv/load'

Dir[File.join(__dir__, 'app', 'lib', 'database_seeds', '*.rb')].each { |file| require_relative file }

namespace :db do
  task :seed do
    DatabaseSeeds::Main.execute
  end
end
