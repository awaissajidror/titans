class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :attendances, dependent: :destroy

  validates :email, presence: true, uniqueness: true

  enum roles: { super_admin: 1, admin: 2, employee: 3 }

  scope :employees, -> { where("role = ?", 3) }
end
