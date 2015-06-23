# Set your full path to application.
app_path = "/var/kanoko/current"
shared_path = "/var/kanoko/shared"

# Set unicorn options
worker_processes 2
preload_app true
timeout 10
listen "/tmp/unicorn.kanoko.sock"

# Spawn unicorn master worker for user apps (group: apps)
user 'deploy', 'deploy'

# Fill path to your app
working_directory app_path

# Log everything to one file
stderr_path "log/unicorn.log"
stdout_path "log/unicorn.log"

# Set master PID location
pid "#{shared_path}/tmp/pids/unicorn.pid"

before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{app_path}/Gemfile"
end

before_fork do |server, worker|
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end
