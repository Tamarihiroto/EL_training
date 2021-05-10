class User < ApplicationRecord
  has_many :tasks, dependent: :delete_all
  has_secure_password

  validates :name, presence: true
  validates :mail, presence: true, uniqueness: true
  validates :password, presence: true

end
