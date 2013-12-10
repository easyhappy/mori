require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'

set :domain,      'www.5ireading.com'
set :user,        'ubuntu'
set :deploy_to,   '/home/ubuntu/Document/mori'
set :repository,  'git@github.com:easyhappy/mori.git'
set :branch,      'master'

task :environment do
  invoke :'rvm:use[ruby-2.0.0-p353@mori]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  #queue! %[mkdir -p "#{deploy_to}/shared/log"]
  #queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]
  #queue! %[mkdir -p "#{deploy_to}/shared/config"]
  #queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]
  #queue! %[touch "#{deploy_to}/config/database.yml"]
  #queue  %[echo  "-----> Be sure to edit 'config/database.yml'."]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    queue 'git pull'
    #queue 'sudo service nginx stop'
    #invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    #invoke :'rails:db_migrate'
    #invoke :'rails:assets_precompile'

    to :launch do
      #queue "touch #{deploy_to}/tmp/restart.txt"
    end
  end
end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers

