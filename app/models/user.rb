class User < ApplicationRecord
  has_many :tasks
  has_secure_password

  validates :name, presence: true
  validates :mail, presence: true, uniqueness: true
  validates :password, presence: true

  enum admin: { true: true, false: false }
end
