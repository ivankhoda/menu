# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
max_threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }
min_threads_count = ENV.fetch('RAILS_MIN_THREADS') { max_threads_count }
threads min_threads_count, max_threads_count

# Specifies the `worker_timeout` threshold that Puma will use to wait before
# terminating a worker in development environments.
#
worker_timeout 3600 if ENV.fetch('RAILS_ENV', 'development') == 'development'
if ENV.fetch('RAILS_ENV', 'production') == 'production'
#   app_root = ENV['APP_ROOT'] || '.'
#   rails_env = ENV['RAILS_ENV'] || 'production'
#   ip_addr = ENV['IP_ADDR'] || 'localhost'
#   port = ENV['PORT'] || 3000
  # ssl_key = ENV['SSL_KEY'] || File.read('config/server.key')
  # ssl_cert = ENV['SSL_CERT'] || File.read('config/server.crt')
#
#   # Set Puma parameters
#   preload_app!
#   rackup DefaultRackup
#   environment rails_env
#   pidfile "#{app_root}/tmp/pids/puma.pid"
#   state_path "#{app_root}/tmp/pids/puma.state"
#   threads 0, 16
#   workers 2
#   stdout_redirect "#{app_root}/log/puma.log", "#{app_root}/log/puma.err", true if rails_env.downcase == 'production'
#
#   # HTTP or HTTPS
#   if ssl_key.present? && ssl_cert.present?
#     ssl_bind '0.0.0.0', 3000, {
#       key: 'config/server.key',
#       cert: 'config/server.crt',
#       verify_mode: 'none'
#   }
  #  else
  #     bind "tcp://#{ip_addr}:#{port}"
  # end
  # localhost_key = 'config/server.key'
  # localhost_crt = 'config/server.crt'
  #
  # ssl_bind '0.0.0.0', 3000, {
  #   key: localhost_key,
  #   cert: localhost_crt,
  #   verify_mode: 'none'
  # }
end
# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
port ENV.fetch('PORT') { 3000 }

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch('RAILS_ENV') { 'development' }

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch('PIDFILE') { 'tmp/pids/server.pid' }

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked web server processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
# workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
#
# preload_app!

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart
