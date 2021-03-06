class User < ActiveRecord::Base
  include SocialMediaAuthentication
  attr_accessor :login

  devise :database_authenticatable,   :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, 
         :omniauth_providers => [:google_oauth2]
  
  def self.find_for_database_authentication(conditions)
    conditions[:email] = conditions.delete(:login)
    user = where(conditions).first
  end

  def admin?
    Setting.admin_emails.include?(self.email)
  end
end
