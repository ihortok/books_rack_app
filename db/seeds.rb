# frozen_string_literal: true

require "#{ENV['APP_FULL_PATH']}/lib/database_seeds"

DatabaseSeeds::Main.execute
