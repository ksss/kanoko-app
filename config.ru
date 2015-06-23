require 'rack-health'
require './app'

GC::Profiler.enable

use Rack::Health
run KanokoApp
