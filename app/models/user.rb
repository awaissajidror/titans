class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ActiveRecord::Relations
  has_many :attendances, dependent: :destroy

  # ActiveRecord::Validations
  validates :email, presence: true, uniqueness: true

  # Custom Queries
  scope :employees, -> { where('role = ?', 3) }
  scope :office_worker, -> { where('role = ?', 4) }
  scope :employee_worker, -> { where(role: [3, 4]) }

  # Define Enums
  enum roles: { super_admin: 1, admin: 2, employee: 3, office_worker: 4 }
end

