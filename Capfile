require 'aws-sdk'
Aws.config[:profile] = ENV["AWS_PROFILE"]
Aws.config[:region] = ENV["AWS_REGION"]
Aws::EC2

require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/bundler'
require 'capistrano/rbenv'
require 'capistrano3/unicorn'
