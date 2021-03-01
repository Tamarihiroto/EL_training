class Task < ApplicationRecord
  enum status: { default: 0, untouched: 1, in_progress: 2, done: 3 }
  enum priority: { high: 0, middle: 1, low: 2, undefine: 3 }
  validates :title, presence: true
  validates :content, length: { maximum: 280 }
end
