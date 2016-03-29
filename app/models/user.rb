class User < ActiveRecord::Base
  extend EnumerateIt
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_enumeration_for :responsibility, with: ResponsibilityType, create_helpers: true
end
