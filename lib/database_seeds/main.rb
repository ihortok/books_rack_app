# frozen_string_literal: true

require "#{ENV['APP_FULL_PATH']}/config/database"
require_relative 'dummy'

module DatabaseSeeds
  # Database Seeds Main
  class Main
    def self.execute
      DatabaseSeeds::Dummy.execute
    end
  end
end
