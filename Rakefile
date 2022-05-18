# frozen_string_literal: true

require 'dotenv/load'

require_relative 'db/db_creator'
require_relative 'db/db_migrator'
require_relative 'db/db_seeder'

namespace :db do
  task :create do
    DBCreator.new.call
  end

  task :migrate do
    DBMigrator.new.call
  end

  task :seed do
    DBSeeder.new.call
  end
end
