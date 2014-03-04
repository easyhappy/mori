module Bar
   autoload :Foo, './autoloaded.rb'
end

t1 = Thread.new { Bar::Foo }
t2 = Thread.new { Bar::Foo }
t1.join; t2.join
