lock '3.4.0'
set :application, 'kanoko'
set :repo_url, 'git@github.com:ksss/kanoko-app.git'
set :deploy_to, "/var/kanoko"
set :format, :pretty
set :log_level, :debug
set :normalize_asset_timestamps, false
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/assets}
set :unicorn_restart_sleep_time, 5
set :pty, true
set :unicorn_config_path, -> { File.join(current_path, "config", "unicorn", "#{fetch(:stage)}.rb") }
set :default_env, {
  kanoko_digest_func: ENV['KANOKO_DIGEST_FUNC'],
  kanoko_secret_key: ENV['KANOKO_SECRET_KEY'],
}

if !ENV['KANOKO_DIGEST_FUNC'] || !ENV['KANOKO_SECRET_KEY']
  fail "[Error]: env 'KANOKO_DIGEST_FUNC' and 'KANOKO_SECRET_KEY' must be set"
end

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

resource = Aws::EC2::Resource.new(client: Aws::EC2::Client.new)
filters = [
  {name: 'instance-state-name', values: ['running']},
  {name: "tag:Name", values: [ENV["EC2_INSTANCE_NAME"]]},
]
set :hosts, resource.instances(filters: filters).to_a

namespace :deploy do
  after :publishing, 'unicorn:restart'
end
