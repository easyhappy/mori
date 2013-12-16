Mori::Application.routes.draw do
  resources :comments

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  devise_for :users, controllers:  { omniauth_callbacks: "users/omniauth_callbacks" ,registrations: "users/registrations"}
  resources  :chapters
  resources  :categories
  resources  :books do
    get :search, on: :collection
  end
  root       "main#index"
end
