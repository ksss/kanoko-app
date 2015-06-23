worker_processes 4
listen "/tmp/unicorn-kanoko.sock"
pid "tmp/pids/unicorn.pid"
preload_app true
