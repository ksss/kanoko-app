set :rbenv_type, :user
set :rbenv_ruby, '2.3.0-dev'
set :unicorn_rack_env, "production"

ips = fetch(:hosts).map(&:public_ip_address)
role :app, ips
role :web, ips
role :db,  ips

set :ssh_options, {
  user: ENV["CAPISTRANO_SSH_USER"],
  keys: fetch(:hosts).map{ |h|
    File.expand_path("~/.ssh/aws/#{h.key_name}.pem")
  }.uniq,
  port: ENV["CAPISTRANO_SSH_PORT"]
}
