class Task < ApplicationRecord
  scope :sorted, lambda { |sort_params|
    order("#{sort_params[:column]} #{sort_params[:direction]}")
  }
  scope :recent, -> { order(created_at: :desc) }
end
