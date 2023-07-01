class Booking < ApplicationRecord
  belongs_to :travel 
  has_many :user_bookings, dependent: :destroy
  has_many :users, through: :user_bookings, inverse_of: :bookings

  

  before_save :ensure_confirmation

  def to_param
    confirmation
  end

  private


  def ensure_confirmation
    return if confirmation

    loop do
      self.confirmation = generate_confirmation_number
      break unless self.class.where(confirmation: confirmation).exists?
    end
  end

  def generate_confirmation_number(size = 6)
    charset = %w{ A C D E F G H J K M N P Q R T V W X Y Z }
    (0...size).map{ charset.to_a[rand(charset.size)] }.join
  end
end
