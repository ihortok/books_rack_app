# frozen_string_literal: true

require 'dotenv/load'
require 'pry'

require_relative 'app/router'

use Rack::Static, urls: ['/images', '/js', '/css'], root: 'public'

run ->(env) { Router.new(env).call }
