Mori::Application.routes.draw do
  mount API => '/grape_api'
  resources :comments


  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  devise_for :users, controllers:  { omniauth_callbacks: "users/omniauth_callbacks" ,registrations: "users/registrations"}
  resources  :chapters
  resources  :categories
  resources  :books do
    get :search, on: :collection
  end
  root       "main#index"

  namespace :api do
    resources :books
    resources :categories
    resources :chapters
  end
end