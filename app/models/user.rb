class User < ActiveRecord::Base
  include SocialMediaAuthentication
  attr_accessor :login, :email

  devise :database_authenticatable,   :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, 
         :omniauth_providers => [:google_oauth2]
  
  def self.find_for_database_authentication(conditions)
    binding.pry
    user = where(conditions).first
  end
end
