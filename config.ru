# frozen_string_literal: true

require 'dotenv/load'
require 'pry'

require_relative 'app/router'

run ->(env) { Router.new(env).call }
