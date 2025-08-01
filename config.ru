# frozen_string_literal: true

require 'dotenv/load'
require 'rack/static'

require_relative 'config/router'

use Rack::Static, urls: ['/images', '/js', '/css'], root: 'public'

run ->(env) { Router.new(env).call }
