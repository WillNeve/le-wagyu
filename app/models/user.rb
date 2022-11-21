class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  has_many :bbqs
  has_many :bookings
  has_many :reviews
  validates_presence_of :first_name, :last_name, :username, :encrypted_password, :email
  validates :username, uniqueness: true
end
