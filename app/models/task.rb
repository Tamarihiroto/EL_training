class Task < ApplicationRecord
  enum status: { untouched: 0, in_progress: 1, done: 2 }
  enum priority: { high: 0, middle: 1, low: 2 }

  validates :title, presence: true
  validates :content, length: { maximum: 280 }
  
  scope :sorted, -> (sort_params) { order("#{sort_params[:column]} #{sort_params[:direction]}") }
  scope :recent, -> { order(created_at: :desc) }

  scope :search, -> (search_params) {
    search_title(search_params[:title]).search_status(search_params[:status])
  }
  scope :search_title, -> (title) { where('title LIKE ?', "%#{title}%") if title.present? }
  scope :search_status, -> (status) { where(status: "#{status}") if status.present? }

  scope :paginate, -> (page_params) { page(page_params).per(15) }
end
