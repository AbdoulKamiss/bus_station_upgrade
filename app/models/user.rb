class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
         
         has_many :user_bookings, dependent: :destroy
         has_many :bookings, through: :user_bookings, inverse_of: :users
         has_many :travels, through: :bookings
end
