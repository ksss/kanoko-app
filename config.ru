require 'rack-health'
require './app'
require 'unicorn/worker_killer'

GC::Profiler.enable
use Unicorn::WorkerKiller::MaxRequests, 128, 256
use Unicorn::WorkerKiller::Oom, 100 * 1024**2, 110 * 1024**2
use Rack::Health
run KanokoApp
