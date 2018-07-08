# require "bundler/capistrano"
#
# #server "208.82.102.152", :web, :app, :db, primary: true
# #server "18.191.175.149", :web, :app, primary: true
#
# set :application, "psp"
# set :user, "ubuntu"
# set :deploy_to, "/home/#{user}/#{application}"
# set :deploy_via, :remote_cache
# set :use_sudo, false
#
# set :scm, 'git'
# #set :repository,  "git@github.com:publicservantsprayer/psp.git"
# set :repository, "git@github.com:fuzzygroup/psp.git"
# set :branch, 'master'
#
# default_run_options[:pty] = true
# ssh_options[:forward_agent] = true
#
# # if you want to clean up old releases on each deploy (keep last 5 releases)
# after "deploy:restart", "deploy:cleanup"
#
# namespace :deploy do
#   %w[start stop restart].each do |command|
#     desc "#{command} unicorn server"
#     task command, roles: :app, except: {no_release: true} do
#       run "/etc/init.d/unicorn_#{application} #{command}"
#     end
#   end
#
#   task :setup_config, roles: :app do
#     sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
#     sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
#     run "mkdir -p #{shared_path}/config/initializers"
#     put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
#     put File.read("config/initializers/mail_chimp.example.rb"), "#{shared_path}/config/initializers/mail_chimp.example.rb"
#     puts "Now edit the config files in #{shared_path}."
#   end
#   after "deploy:setup", "deploy:setup_config"
#
#   task :symlink_config, roles: :app do
#     run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
#     run "ln -nfs #{shared_path}/config/initializers/mail_chimp.rb #{release_path}/config/initializers/mail_chimp.rb"
#     run "ln -nfs #{shared_path}/photos #{release_path}/public/photos"
#   end
#   after "deploy:finalize_update", "deploy:symlink_config"
#
#   desc "Make sure local git is in sync with remote."
#   task :check_revision, roles: :web do
#     unless `git rev-parse HEAD` == `git rev-parse origin/master`
#       puts "WARNING: HEAD is not the same as origin/master"
#       puts "Run `git push` to sync changes."
#       exit
#     end
#   end
#   before "deploy", "deploy:check_revision"
# end





# config valid for current version and patch releases of Capistrano
#lock "~> 3.11.0"

set :application, "psp"
set :repo_url, "git@github.com:fuzzygroup/psp.git"
set :deploy_user, 'ubuntu'
set :rbenv_type, :user
set :aws_region, 'us-east-2'
set :default_shell, '/bin/bash -l'
#set :rbenv_ruby, -> {`cat .ruby-version`.strip }
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/ubuntu/psp"

set :pty, true

set :ssh_options, {
  forward_agent: true,
  auth_methods: ["publickey"],
  keys: ["/Users/sjohnson/.ssh/new-leaders.pem"]
}

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 2

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure





