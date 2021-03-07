class Task < ApplicationRecord
  enum status: { default: 0, untouched: 1, in_progress: 2, done: 3 }
  validates :title, presence: true
  validates :content, length: { maximum: 280 }
  
  scope :sorted, lambda { |sort_params|
    order("#{sort_params[:column]} #{sort_params[:direction]}")
  }
  scope :recent, -> { order(created_at: :desc) }

  scope :search, lambda { |title, status|
    where('title LIKE ?', "%#{title}%").where(status: "#{status}")
  }
end
