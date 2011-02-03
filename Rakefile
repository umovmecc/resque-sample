$LOAD_PATH.unshift File.dirname(__FILE__) + '/../../lib'
require 'resque/tasks'
require 'job'

desc "Start the demo using `rackup`"
task :start do
  exec "rackup config.ru"
end

desc "starting worker 'default'"
task :start_worker do
  exec "ENV['AUTH']=tt VERBOSE=true QUEUE=default rake resque:work"
end

