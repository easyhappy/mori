#coding: utf-8

def create_shared_dirs
  base_path = 'shared'
  %w{pids sockets log}.each do |dir|
    path = File.join(base_path, dir)
    system("mkdir -p #{path}")
    puts "mkdir -p #{path}"
  end
end

def create_secret_token
  File.open("./config/initializers/secret_token.rb", 'w') do |file|
    file.write("Mori::Application.config.secret_token =''")
  end
end

create_shared_dirs
create_secret_token