# 自动加载文件
auto_required_paths = %W(lib)

auto_required_paths.each do |d|
  Dir["#{Rails.root}/#{d}/*.rb"].each {|p| require p}
end