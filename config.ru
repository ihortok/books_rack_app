# frozen_string_literal: true

require_relative 'app/router'

run ->(env) { Router.new(env).call }
