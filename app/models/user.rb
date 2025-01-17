# Devise user class
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: { message: 'Please enter your First Name' }
  validates :last_name, presence: { message: 'Please enter your Last Name' }
  validates :timezone, presence: { message: 'Please select a Time Zone' }

  has_many :accounts, dependent: :destroy
end
