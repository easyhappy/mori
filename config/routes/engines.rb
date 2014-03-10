Mori::Application.routes.draw do
  mount Blorgh::Engine, :at => "/blog"
end