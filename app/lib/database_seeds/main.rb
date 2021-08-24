# frozen_string_literal: true

require_relative '../../config/db'

module DatabaseSeeds
  # Database Seeds Main
  class Main
    def self.execute
      DatabaseSeeds::Dummy.execute
    end
  end
end
