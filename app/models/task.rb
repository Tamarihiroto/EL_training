class Task < ApplicationRecord
  enum status: { default: 0, untouched: 1, in_progress: 2, done: 3 }
  validates :title, presence: true
  validates :content, length: { maximum: 280 }
  
  scope :sorted, -> (sort_params) { order("#{sort_params[:column]} #{sort_params[:direction]}") }
  scope :recent, -> { order(created_at: :desc) }

  scope :search, -> (search_params) {
    search_title(search_params[:title]).search_status(search_params[:status])
  }
  scope :search_title, -> (title) { where('title LIKE ?', "%#{title}%") if title.present? }
  scope :search_status, -> (status) { where(status: "#{status}") if status.present? }

  scope :split_tasks_on_a_page, -> (page_params) { page(page_params).per(20) }
end
