root_path = File.expand_path('../../../', __FILE__)

worker_processes 2
working_directory "#{root_path}/current"
pid "#{root_path}/shared/tmp/pids/unicorn.pid"
listen "#{root_path}/shared/tmp/sockets/.unicorn.sock"
stderr_path "#{root_path}/shared/log/unicorn.stderr.log"
stdout_path "#{root_path}/shared/log/unicorn.stdout.log"

$app_dir = "/var/www/rails/rails-deploy"
$timeout = 30

$std_log = File.expand_path 'log/unicorn.log', $app_dir
timeout $timeout
preload_app true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin 
      Process.kill "QUIT", File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end



# ここからコメントアウト
# rootパスのディレクトリを指定（「../」が先頭に追加）
# root_path = File.expand_path('../../../', __FILE__)

# # アプリケーションサーバの性能を決定する
# # worker_processes 2

# # ポート番号を指定（shared内に変更）
# # listen "#{root_path}/shared/tmp/sockets/unicorn.sock"



# $worker = 2
# $timeout = 30
# # $app_dir = "/var/www/rails/rails-deploy"
# $listen = File.expand_path 'tmp/sockets/.unicorn.sock', $app_dir
# # $pid = File.expand_path 'tmp/pids/unicorn.pid', $app_dir
# $std_log = File.expand_path 'log/unicorn.log', $app_dir

# worker_processes $worker
# # アプリケーションの設置されているディレクトリを指定（current内に変更）
# # working_directory $app_dir
# working_directory "#{root_path}/current"
# # stderr_path $std_log
# # stdout_path $std_log
# # エラーのログを記録するファイルを指定（shared内に変更）
# stderr_path "#{root_path}/shared/log/unicorn.stderr.log"
# # 通常のログを記録するファイルを指定（shared内に変更）
# stdout_path "#{root_path}/shared/log/unicorn.stdout.log"
# timeout $timeout
# listen $listen
# # プロセスIDの保存先を指定（shared内に変更）
# # pid $pid
# pid "#{root_path}/shared/tmp/pids/unicorn.pid"

# preload_app true

# before_fork do |server, worker|
#   defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
#   old_pid = "#{server.config[:pid]}.oldbin"
#   if old_pid != server.pid
#     begin 
#       Process.kill "QUIT", File.read(old_pid).to_i
#     rescue Errno::ENOENT, Errno::ESRCH
#     end
#   end
# end

# after_fork do |server, worker|
#   defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
# end

