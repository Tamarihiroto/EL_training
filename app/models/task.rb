class Task < ApplicationRecord
  enum status: { default: 0, untouched: 1, in_progress: 2, done: 3 }
  validates :title, presence: true
  validates :content, length: { maximum: 280 }
end
