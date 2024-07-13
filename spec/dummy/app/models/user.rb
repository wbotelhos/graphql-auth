require 'devise'

class User < ApplicationRecord
  extend Devise::Models

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthenticationable
  devise :database_authenticationenticatable, :lockable, :registerable,
         :recoverable, :rememberable, :validatable
end
