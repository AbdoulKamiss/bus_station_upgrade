class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
         
         has_many :user_bookings, dependent: :destroy
         has_many :bookings, through: :user_bookings, inverse_of: :users
         has_many :travels, through: :bookings

         validates :name, presence: true 
         validates :email, presence: true
         

         def self.guest
          find_or_create_by!(email: "guest@gmail.com") do |user|
            user.name = "Ablo"
            user.email = "guest@gmail.com"
            user.password = SecureRandom.urlsafe_base64
            user.password_confirmation = user.password
            user.confirmed_at = DateTime.now
            user.admin = false
          end
        end
      
        def self.admin
          find_or_create_by!(email: "admin2@gmail.com") do |user|
            user.name = "Momo"
            user.email = "admin2@gmail.com"
            user.password = SecureRandom.urlsafe_base64
            user.password_confirmation = user.password
            user.confirmed_at = DateTime.now
            user.admin = true
          end
        end
end
